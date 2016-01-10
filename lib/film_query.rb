class FilmQuery
  RESULTS_PER_SOURCE = 10

  class << self
    def sources
      @@sources ||= [
        Source::AmazonInstantVideo.new,
        Source::BBCIplayer.new,
        Source::BFIPlayer.new,
        Source::Blinkbox.new,
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
    rentals.
      group_by { |sr| sr.title.normalised }.
      map { |f| Film.new(f.last.first.title, :rentals => f.last) }.
      sort_by { |f| ((self.class.sources.size - f.rentals.size) * RESULTS_PER_SOURCE * 1.5) + f.rentals.sum(&:search_rank) } # Prioritize those which are most highly ranked in source searches
  end

  def unavailable_sources
    fetch unless fetched?
    @unavailable_sources
  end

  private
  attr_accessor :query, :rentals
  attr_writer :unavailable_sources

  def fetched?
    @fetched
  end

  def fetch
    results = Parallel.map(self.class.sources, :in_threads => self.class.sources.size) do |source|
      begin
        [source.search(query).take(RESULTS_PER_SOURCE), nil]
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
