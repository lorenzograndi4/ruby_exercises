class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  def <=>(other)
    name.length <=> other.name.length
  end
end

people = [Person.new('Sebass'),
  Person.new('Julik'),
  Person.new('Noah'),
  Person.new('Balthasar')
]

puts people.sort
