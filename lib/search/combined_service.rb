module Search
  class CombinedService
    def initialize(query)
      self.query = query
    end

    def results
      @results ||= services.map(&:results).flatten
    end

    private
    attr_accessor :query

    def services
      [
        Search::BlinkBox,
        Search::Film4oD,
        Search::GooglePlay
      ].map { |klass| klass.new(query) }
    end
  end
end
