require 'blinkbox_films'

module Source
  class Blinkbox
    MAX_NUMBER_OF_RESULTS = 5

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
          :title => Title.new(result[:title]),
          :url => result[:url],
          :image_url => result[:image_url],
          :image_quality_rank => 3,
          :search_rank => i
      }
    end
  end
end
