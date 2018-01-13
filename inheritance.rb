# Codaisseur inheritance

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hi #{name} how you doin'"
  end
end

class Kid < Person
  attr_reader :tv_show

  def initialize(name, tv_show)
    @tv_show = tv_show
    super(name)
  end

  def rant
    puts "I'm #{name} and I watch #{tv_show}" # No need for instance vars here bc of attr_reader
  end
end

lolo = Kid.new("Lolo", "McGyver")
lolo.greet
lolo.rant
