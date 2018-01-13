class Tool
  def initialize(size)
    @size = size
  end

  def size
    @size
  end
end

class Toolbox
  def initialize(name)
    @name = name
    @tools = []
  end

  def add_tool(tool)
    raise ArgumentError.new('add the size!') unless tool.respond_to? :size
    @tools << tool
  rescue ArgumentError => e
    puts "You may want to #{e}"
  end

  def each(&block)
    raise ArgumentError.new('pass a block!') unless block
    @tools.each do |tool|
      block.call(tool)
    end
  rescue ArgumentError => e
    puts "You should really #{e}"
  end
end

box = Toolbox.new('My box')
wrench = Tool.new(44)
screwdriver = Tool.new(23)
pen = Object.new
box.add_tool(wrench)
box.add_tool(screwdriver)
box.add_tool(pen)

box.each { |tool| puts tool.inspect }