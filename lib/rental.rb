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
    self.price <=> other.price
  end

  protected
  attr_reader :attributes
end
