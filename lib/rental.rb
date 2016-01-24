class Rental
  include Comparable

  TV_EPISODE_TYPE = :tv_episode
  FILM_TYPE = :movie

  RELEASE_YEAR_MARGIN = 1
  RUNNING_TIME_MARGIN = 10

  def initialize(attributes)
    @attributes = attributes
  end

  def title
    attributes[:title]
  end

  def url
    attributes[:url]
  end

  def service
    attributes[:service]
  end

  def prices=(prices)
    attributes[:prices] = prices
  end

  def prices
    attributes[:prices] || []
  end

  def image_url
    attributes[:image_url]
  end

  def search_rank
    attributes[:search_rank]
  end

  def year=(year)
    attributes[:year] = year
  end

  def year
    attributes[:year]
  end

  def certificate
    attributes[:certificate]
  end

  def type
    attributes[:type]
  end

  def length_in_minutes
    attributes[:length_in_minutes]
  end

  def image_quality_rank
    attributes[:image_quality_rank]
  end

  def ==(other)
    self.attributes == other.attributes
  end

  def <=>(other)
    if self.prices.empty?
      if other.prices.empty?
        0
      else
        1
      end
    elsif other.prices.empty?
      -1
    else
      self.prices.sort <=> other.prices.sort
    end
  end

  def match_film?(film)
    title.normalised == film.title.normalised &&
      (year.nil? || film.year.nil? || (year.to_i - film.year.to_i).abs <= RELEASE_YEAR_MARGIN) &&
      (type.nil? || film.type.nil? || type == film.type) &&
      (certificate.nil? || film.certificate.nil? || certificate == film.certificate) &&
      (length_in_minutes.nil? || film.length_in_minutes.nil? || (length_in_minutes - film.length_in_minutes).abs < RUNNING_TIME_MARGIN)
  end

  protected
  attr_reader :attributes
end
