class FilmQuery
  class << self
    def sources
      @@sources ||= [
        Source::AmazonInstantVideo.new,
        Source::BBCIplayer.new,
        Source::BFIPlayer.new,
        Source::TalkTalkTV.new,
        Source::GooglePlay.new,
        Source::Itunes.new
      ]
    end
  end

  def initialize(query)
    self.query = query
  end

  def films
    fetch unless fetched?
    Film.films_from_rentals(rentals).
      sort_by { |f| ((self.class.sources.size - f.rentals.size) * max_results_per_source * 1.5) + f.rentals.sum(&:search_rank) } # Prioritize those which are most highly ranked in source searches
  end

  def unavailable_sources
    fetch unless fetched?
    @unavailable_sources
  end

  private
  attr_accessor :query, :rentals
  attr_writer :unavailable_sources

  def max_results_per_source
    fetch unless fetched?
    rentals.group_by(&:service).values.map(&:size).max
  end

  def fetched?
    @fetched
  end

  def fetch
    results = Parallel.map(self.class.sources, :in_threads => self.class.sources.size) do |source|
      begin
        [source.search(query), nil]
      rescue StandardError => e
        Rails.logger.error("Failed to query #{source} because of exception #{e}\n#{e.backtrace}")
        [[], source]
      end
    end
    self.rentals = results.map { |r| r.first }.flatten
    self.unavailable_sources = results.map { |r| r.last }.reject(&:nil?)
    @fetched = true
  end
end
