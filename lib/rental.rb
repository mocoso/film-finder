# encoding: utf-8
class Rental
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

  def price_in_pence
    if match = price.match(/£(\d+\.\d*)/)
      (match[1].to_f * 100).to_i
    else
      0
    end
  end

  def image_url
    attributes[:image_url]
  end

  def ==(other)
    self.attributes == other.attributes
  end

  protected
  attr_reader :attributes
end
