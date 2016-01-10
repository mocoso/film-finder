class Film
  attr_reader :rentals

  class << self
    def films_from_rentals(rentals)
      rentals.inject([]) do |films, r|
        if existing_match = films.detect { |f| r.match_film?(f) }
          existing_match.rentals << r
        else
          films << Film.new([r])
        end

        films
      end
    end
  end

  def initialize(rentals)
    @rentals = rentals
  end

  def title
    @rentals.first.title
  end

  def year
    @rentals.map(&:year).select(&:present?).first
  end

  def certificate
    @rentals.map(&:certificate).select(&:present?).first
  end

  def ==(other)
    title == other.title && rentals == other.rentals
  end
end
