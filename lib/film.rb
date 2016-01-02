class Film
  attr_reader :title, :rentals

  def initialize(title, options)
    @title = title
    @rentals = options[:rentals].sort
  end

  def ==(other)
    title == other.title && rentals == other.rentals
  end
end
