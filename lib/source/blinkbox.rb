require 'blinkbox_films'

module Source
  class Blinkbox
    def name
      'Blinkbox'
    end

    def url
      'http://www.blinkbox.com/'
    end

    def search(query)
      BlinkboxFilms::Search.new.search(query).map { |result|
        Rental.new \
          :service => name,
          :title => Title.new(result[:title]),
          :url => result[:url],
          :image_url => result[:image_url]
      }
    end
  end
end
