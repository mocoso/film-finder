class Film
  attr_reader :rentals

  class << self
    def films_from_rentals(rentals)
      rentals.sort_by(&:search_rank).inject([]) do |films, r|
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

  def release_year
    @rentals.map(&:release_year).select(&:present?).first
  end

  def certificate
    @rentals.map(&:certificate).select(&:present?).first
  end

  def length_in_minutes
    @rentals.map(&:length_in_minutes).select(&:present?).first
  end

  def image_url
    @rentals.sort_by(&:image_quality_rank).map(&:image_url).select(&:present?).first
  end

  def type
    @rentals.map(&:type).select(&:present?).first
  end

  def ==(other)
    title == other.title && rentals == other.rentals
  end
end
