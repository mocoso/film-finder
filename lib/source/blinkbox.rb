require 'blinkbox_films'

module Source
  class Blinkbox
    MAX_NUMBER_OF_RESULTS = 10
    MAX_NUMBER_TO_FETCH_ADDITIONAL_INFO_FOR = 3

    def name
      'TalkTalk TV'
    end

    def url
      'http://www.blinkbox.com/'
    end

    def search(query)
      rentals = raw_results(query).each_with_index.map { |result, i|
        Rental.new \
          :service => name,
          :title => Title.new(result.title),
          :url => result.url,
          :image_url => result.image_url,
          :image_quality_rank => 3,
          :certificate => result.certificate,
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
      BlinkboxFilms::Search.new.search(query).take(MAX_NUMBER_OF_RESULTS)
    end

    def fetch_additional_info_for_rental(rental)
      film_from_page = BlinkboxFilms::FilmPage.from_url(rental.url).film
      rental.year = film_from_page.release_year

      rental.prices = [
        film_from_page.rental_price && Price.new("Rent from #{film_from_page.rental_price}"),
        film_from_page.buy_price && Price.new("Buy from #{film_from_page.buy_price}")
      ].compact
    end
  end
end
