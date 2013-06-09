class Rental
  include Comparable

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

  def price
    attributes[:price]
  end

  def image_url
    attributes[:image_url]
  end

  def ==(other)
    self.attributes == other.attributes
  end

  def <=>(other)
    if self.price.is_a? NoPrice
      if other.price.is_a? NoPrice
        0
      else
        1
      end
    elsif other.price.is_a? NoPrice
      -1
    else
      self.price <=> other.price
    end
  end

  protected
  attr_reader :attributes
end
