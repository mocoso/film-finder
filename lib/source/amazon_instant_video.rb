module Source
  class AmazonInstantVideo
    MAX_NUMBER_OF_RESULTS = 5

    def name
      'Amazon Instant Video'
    end

    def url
      'http://www.amazon.co.uk/Instant-Video/b/?node=3010085031'
    end

    def search(query)
      raw_results(query).take(MAX_NUMBER_OF_RESULTS).each_with_index.map do |result, i|
        Rental.new \
          :service => name,
          :title => Title.new(result['ItemAttributes']['Title']),
          :url => result['DetailPageURL'],
          :type => result['ItemAttributes']['ProductGroup'] == 'Movie' ? Rental::FILM_TYPE : Rental::TV_EPISODE_TYPE,
          :image_quality_rank => 10,
          :search_rank => i
      end
    end

    private
    def raw_results(query)
      Rails.cache.fetch("#{self.class.name}::search::#{query}", expires_in: 1.hour) do
        request = Vacuum.new('GB')
        request.associate_tag = ENV['AWS_ASSOCIATE_TAG']
        response = request.item_search(
          :query => {
            'Keywords' => query,
            'SearchIndex' => 'UnboxVideo',
            'Availability' => 'Available'
          }
        )
        results = response.parse['ItemSearchResponse']['Items']['Item']

        if results.nil?
          []
        elsif results.is_a? Hash
          [results]
        else
          results
        end
      end
    end
  end
end
