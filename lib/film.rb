class Film
  attr_reader :title, :rentals

  def initialize(title, options)
    @title = title
    @rentals = options[:rentals].sort_by(&:price_in_pence)
  end

  def ==(other)
    title == other.title && rentals == other.rentals
  end

  def number_of_words_matching_query(query)
    (title.downcase.split(/\W/).compact & query.downcase.split(/\W/).compact).size
  end
end
