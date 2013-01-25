module Search
  class Result
    def initialize(attributes)
      @attributes = attributes
    end

    def title
      attributes[:title]
    end

    def ==(other)
      self.attributes == other.attributes
    end

    protected
    attr_reader :attributes
  end
end
