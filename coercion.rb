class Roman
  FACTORS = [
    ["m", 1000], ["cm", 900], ["d", 500], ["cd", 400],
    ["c",  100], ["xc",  90], ["l",  50], ["xl",  40],
    ["x",   10], ["ix",   9], ["v",   5], ["iv",   4],
    ["i",    1]
  ]

  def initialize(value)
    raise(ArgumentError, "Integer expected, not #{value.class.name}") unless value.is_a? Integer

    @value = value
  end

  def to_int
    @value
  end

  def to_s
    roman = ""
    remainder = @value + 0

    while remainder > 0
      FACTORS.each do |factor|
        amount = factor.last

        if remainder - amount >= 0
          roman << factor.first
          remainder -= amount
          break
        end
      end
    end

    roman.upcase
  end
end

xiv = Roman.new(14)
puts xiv.to_int #=> 14
puts xiv.to_s #=> xiv

mmmmcmlxxviii = Roman.new(4978)
puts mmmmcmlxxviii.to_int
puts mmmmcmlxxviii.to_s