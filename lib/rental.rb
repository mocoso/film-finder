class Rental
  include Comparable

  TV_EPISODE_TYPE = :tv_episode
  FILM_TYPE = :movie

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

  def prices
    attributes[:prices] || []
  end

  def image_url
    attributes[:image_url]
  end

  def search_rank
    attributes[:search_rank]
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
      (year.nil? || film.year.nil? || year == film.year) &&
      (type.nil? || film.type.nil? || type == film.type)
  end

  protected
  attr_reader :attributes
end
