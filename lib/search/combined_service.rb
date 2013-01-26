module Search
  class CombinedService
    def initialize(query, hydra)
      self.query = query
      self.hydra = hydra
    end

    def results
      unless @results
        services.each { |s| hydra.queue(s.request) }
        hydra.run
        @results = services.map(&:results).flatten
      end

      @results
    end

    private
    attr_accessor :query, :hydra

    def services
      @services ||= [
        Search::BlinkBox,
        Search::Film4oD,
        Search::GooglePlay
      ].map { |klass| klass.new(query) }
    end
  end
end
