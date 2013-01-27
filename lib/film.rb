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
    (split_into_normalized_words(title) & split_into_normalized_words(query)).size
  end

  private
  def split_into_normalized_words(string)
    string.downcase.gsub('-', '').split(/\W/).reject(&:blank?)
  end
end
