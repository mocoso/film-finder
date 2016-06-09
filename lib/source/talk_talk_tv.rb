require 'talktalk_tv'

module Source
  class TalkTalkTV
    MAX_NUMBER_OF_RESULTS = 10
    MAX_NUMBER_TO_FETCH_ADDITIONAL_INFO_FOR = 3

    def name
      'TalkTalk TV'
    end

    def url
      'https://www.talktalktvstore.co.uk/'
    end

    def search(query)
      rentals = raw_results(query).each_with_index.map { |result, i|
        Rental.new \
          :service => name,
          :title => Title.new(result.title),
          :url => result.url,
          :image_url => result.image_url,
          :image_quality_rank => 3,
          :certificate => result.certificate == 'NR' ? nil : result.certificate,
          :type => Rental::FILM_TYPE,
          :length_in_minutes => result.running_time_in_minutes,
          :search_rank => i
      }

      Parallel.each(rentals.take(MAX_NUMBER_TO_FETCH_ADDITIONAL_INFO_FOR), :in_threads => MAX_NUMBER_TO_FETCH_ADDITIONAL_INFO_FOR) do |rental|
        fetch_additional_info_for_rental(rental)
      end

      rentals
    end

    private
    def raw_results(query)
      Rails.cache.fetch("#{self.class.name}::search::#{query}", expires_in: 1.hour) do
        ::TalkTalkTV::Search.new.search(query).take(MAX_NUMBER_OF_RESULTS)
      end
    end

    def fetch_additional_info_for_rental(rental)
      film_with_additional_info = film_from_page(rental.url)
      rental.release_year = film_with_additional_info.release_year

      rental.prices = [
        film_with_additional_info.rental_price && Price.new("Rent from #{film_with_additional_info.rental_price}"),
        film_with_additional_info.buy_price && Price.new("Buy from #{film_with_additional_info.buy_price}")
      ].compact
    end

    def film_from_page(url)
      Rails.cache.fetch("#{self.class.name}::film::#{url}", expires_in: 1.week) do
        ::TalkTalkTV::FilmPage.from_url(url).film
      end
    end
  end
end
