class FilmQuery
  class << self
    def sources
      @@sources ||= [
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
      group_by { |sr| sr.title.downcase }.
      map { |f| Film.new(f.last.first.title, :rentals => f.last) }.
      sort_by { |f| [f.rentals.size, f.number_of_words_matching_query(query)] }.reverse # Prioritize those which are returned by multiple services
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
        [source.search(query).take(10), nil]
      rescue StandardError => e
        Rails.logger.error("Failed to query #{source} because of exception #{e}")
        [[], source]
      end
    end
    self.rentals = results.map { |r| r.first }.flatten
    self.unavailable_sources = results.map { |r| r.last }.reject(&:nil?)
    @fetched = true
  end
end
