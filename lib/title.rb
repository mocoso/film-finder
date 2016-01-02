class Title
  def initialize(name)
    @name = name
  end

  def to_s
    @name
  end

  def normalised
    @name.
      downcase.
      gsub(/ \(\d{4}\)$/, '').
      gsub(/&/, 'and').
      gsub(/[^\w\s]/, '').
      gsub(/\s+/, ' ').
      gsub(/\bi\b/, '1').
      gsub(/\bii\b/, '2').
      gsub(/\biii\b/, '3').
      gsub(/\biv\b/, '4').
      gsub(/\bv\b/, '5').
      gsub(/\bvi\b/, '6').
      gsub(/\bvii\b/, '7').
      gsub(/\bviii\b/, '8').
      gsub(/\bix\b/, '9').
      gsub(/\bx\b/, '10')
  end
end
