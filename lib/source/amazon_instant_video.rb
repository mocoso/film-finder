module Source
  class AmazonInstantVideo

    def name
      'Amazon Instant Video'
    end

    def url
      'http://www.amazon.co.uk/Instant-Video/b/?node=3010085031'
    end

    def search(query)
      raw_results(query).each_with_index.map do |result, i|
        Rental.new \
          :service => name,
          :title => Title.new(result['ItemAttributes']['Title']),
          :url => result['DetailPageURL'],
          :search_rank => i
      end
    end

    private
    def raw_results(query)
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
