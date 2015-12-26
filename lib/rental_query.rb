class RentalQuery
  attr_reader :source

  def initialize(query, source)
    self.query = query
    self.source = source
  end

  def rentals
    @rentals ||= rental_fragments.map do |fragment|
      rental fragment
    end
  end

  def request
    @request ||= Typhoeus::Request.new \
      source.search_url(query),
      :proxy => ENV['HTTP_PROXY']
  end

  def error?
    !request.response.success?
  end


  private
  attr_writer :source
  attr_accessor :query

  def page
    request.response.body
  end

  def rental_fragments
    source.rental_fragments(page)
  end

  def rental(rental_fragment)
    Rental.new \
      :service   => source.name,
      :title     => source.rental_title(rental_fragment),
      :url       => source.rental_url(rental_fragment),
      :image_url => source.rental_image_url(rental_fragment),
      :price     => source.rental_price(rental_fragment)
  end
end

