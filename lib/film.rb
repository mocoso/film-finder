class Film
  attr_reader :title, :rentals

  def initialize(title, options)
    @title = title
    @rentals = options[:rentals].sort
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
