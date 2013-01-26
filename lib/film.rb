class Film
  attr_reader :title, :rentals

  def initialize(title, options)
    @title = title
    @rentals = options[:rentals].sort_by(&:price_in_pence)
  end

  def ==(other)
    title == other.title && rentals == other.rentals
  end
end
