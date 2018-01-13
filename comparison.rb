class TShirtSize
  include Comparable

  def initialize(size)
    @size = size.upcase
  end

  def to_s
    @size
  end

  def <=>(other)
    return nil unless other.respond_to? :numeric_size

    self.numeric_size <=> other.numeric_size
  end

  def numeric_size
    amount_of_x_characters = @size.count('X')

    case @size.chars.last
    when "S"
      return 1 - amount_of_x_characters
    when "M"
      return 2
    when "L"
      return 3 + amount_of_x_characters
    end
  end
end

xl         = TShirtSize.new("XL")
m          = TShirtSize.new("M")
xs         = TShirtSize.new("XS")
another_xs = TShirtSize.new("XS")

p xs < xl                     # => true
p xs == another_xs            # => true
p m.between?(xs, xl)          # => true
p another_xs.between?(xs, xl) # => true
