class FilmQuery
  class << self
    def hydra
      @@hydra ||= Typhoeus::Hydra.new
    end

    def sources
      @@sources ||= [
        Source::BlinkBox.new,
        Source::Film4oD.new,
        Source::GooglePlay.new
      ]
    end
  end

  def initialize(query)
    self.query = query
  end

  def films
    @films ||= rentals.
      group_by { |sr| sr.title.downcase }.
      map { |f| Film.new(f.last.first.title, :rentals => f.last) }.
      select { |f| f.number_of_words_matching_query(query) > 0 }. # Reject those who don't seem good enough matches - I am looking at you Google Play
      sort_by { |f| [f.number_of_words_matching_query(query), f.rentals.size] }.reverse # Prioritize those which are returned by multiple services
  end

  private
  attr_accessor :query, :hydra

  def rentals
    unless @rentals
      rental_queries.each { |s| self.class.hydra.queue(s.request) }
      self.class.hydra.run
      @rentals = rental_queries.map(&:rentals).flatten
    end

    @rentals
  end

  def rental_queries
    @rental_queries ||= self.
      class.
      sources.
      map { |source| RentalQuery.new query, source }
  end
end
