class Wardrobe < Object
  class BlockError < StandardError; end

  def initialize(name)
    @name = name
    @clothes = []
  end

  def add_cloth(cloth)
    @clothes << cloth
  end

  def each(&block)
    raise BlockError, 'pass a block!' unless block
    @clothes.each do |item|
      block.call(item)
    end
  rescue BlockError => e
    puts "Dude, you should really #{e.message}"
  end
end

leisure_clothes = Wardrobe.new('leisure clothes')

leisure_clothes.add_cloth("TV onesie")
leisure_clothes.add_cloth("Yoga pants")
leisure_clothes.add_cloth("The dude bathrobe")

# We want to iterate over all clothes, and print the names:
leisure_clothes.each { |item| puts item }

# And we even want to count the amount of clothes we have:
# p leisure_clothes.count