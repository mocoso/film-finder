# encoding: utf-8
class Price
  include Comparable

  def initialize(description)
    @description = description
  end

  def to_s
    @description
  end

  def <=>(other)
    in_pence <=> other.in_pence
  end

  protected
  def in_pence
    if match = to_s.match(/£(\d+\.\d*)/)
      (match[1].to_f * 100).to_i
    else
      0
    end
  end
end
