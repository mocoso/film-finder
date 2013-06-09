class NoPrice
  def initialize(description)
    @description = description
  end

  def to_s
    description
  end

  def ==(other)
    self.description == other.description
  end

  protected
  attr_reader :description
end
