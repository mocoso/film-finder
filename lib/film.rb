class Film
  attr_reader :title, :results

  def initialize(title, options)
    @title = title
    @results = options[:results].sort_by(&:price_in_pence)
  end

  def ==(other)
    title == other.title && results == other.results
  end
end
