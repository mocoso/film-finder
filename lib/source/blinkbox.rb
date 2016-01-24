require 'blinkbox_films'

module Source
  class Blinkbox
    MAX_NUMBER_OF_RESULTS = 10

    def name
      'TalkTalk TV'
    end

    def url
      'http://www.blinkbox.com/'
    end

    def search(query)
      BlinkboxFilms::Search.new.search(query).take(MAX_NUMBER_OF_RESULTS).each_with_index.map { |result, i|
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
    end
  end
end
