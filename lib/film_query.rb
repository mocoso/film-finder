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
      select { |f| f.number_of_words_matching_query(query) > 0 }. # Reject those who don't seem good enough matches - I am looking at you Google Play
      sort_by { |f| [f.number_of_words_matching_query(query), f.rentals.size] }.reverse # Prioritize those which are returned by multiple services
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
    rentals = []
    unavailable_sources = []
    self.class.sources.each do |source|
      begin
        rentals+= source.search(query)
      rescue StandardError => e
        unavailable_sources << source
        Rails.logger.error("Failed to query #{source} because of exception #{e}")
      end
    end
    self.rentals = rentals
    self.unavailable_sources = unavailable_sources
    @fetched = true
  end
end
