class Film
  attr_reader :rentals

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
