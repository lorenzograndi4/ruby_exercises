# 2018.01.12/13 Advanced Ruby

## Inheritance
Inheritance is a relation between two classes. We know that all cats are mammals, and all mammals are animals. The benefit of inheritance is that classes lower down the hierarchy get the features of those higher up, but can also add specific features of their own. If all mammals breathe, then all cats breathe. In Ruby, a class can only inherit from a single other class. In OO terminology, the smaller class is a subclass and the larger class is a super-class.
Rather than exhaustively define every characteristic of every new class, we need only to append or to redefine the differences between each subclass and its super-class. Inheritance is indicated with <. A class can only inherit from one class at a time.
When you invoke super with arguments, Ruby sends a message to the parent of the current object, asking it to invoke a method of the same name as the method invoking super. super sends exactly those arguments.You may be tempted to say that these variables are inherited. That is not how Ruby works. All Ruby objects have a set of instance variables. These are not defined by the objects's class - they are simply created when a value is assigned to them. Because instance variables are not defined by a class, they are unrelated to subclassing and the inheritance mechanism. The reason that they sometimes appear to be inherited is that instance variables are created by the methods that first assign values to them, and those methods are often inherited or chained. Since instance variables have nothing to do with inheritance, it follows that an instance variable used by a subclass cannot "shadow" an instance variable in the super-class. If a subclass uses an instance variable with the same name as a variable used by one of its ancestors, it will overwrite the value of its ancestor's variable.

## Modules
Modules define a namespace, a sandbox in which your methods and constants can play without having to worry about being stepped on by other methods and constants. They pretty much eliminate the need for multiple inheritance, providing a facility called a mixin. If this made you think of class methods, your next thought might well be ‘what happens if I define instance methods within a module?’ Good question. A module can't have instances, because a module isn't a class. However, you can include a module within a class definition. When this happens, all the module's instance methods are suddenly available as methods in the class as well. They get mixed in. In fact, mixed-in modules effectively behave as superclasses. A couple of points about the include statement before we go on. First, it has nothing to do with files. The Ruby include statement simply makes a reference to a named module. If that module is in a separate file, you must use require to drag that file in before using include. Second, a Ruby include does not simply copy the module's instance methods into the class. Instead, it makes a reference from the class to the included module. If multiple classes include that module, they'll all point to the same thing. If you change the definition of a method within a module, even while your program is running, all classes that include that module will exhibit the new behaviour. Mixins give you a wonderfully controlled way of adding functionality to classes. However, their true power comes out when the code in the mixin starts to interact with code in the class that uses it.

## Monkey patching
The term monkey patch seems to have come from an earlier term, guerrilla patch, which referred to changing code sneakily – and possibly incompatibly with other such patches – at runtime. The word guerrilla, homophonous with gorilla (or nearly so), became monkey, possibly to make the patch sound less intimidating. An alternative etymology is that it refers to “monkeying about” with the code (messing with it). (source: https://en.wikipedia.org/wiki/Monkey_patch)
It has a somewhat foul smell: You change a body of code, but it is not our code, it is a programming language (or framework) you are depending on. That means that it compromises the stability of the foundation you're building on.
When adding code to classes that aren't yours, you take a gamble on the future of the code you depend on, you have code that is less easy to google for new team members. As an added bonus the resulting code is surprisingly hard to maintain in the long run.
Ruby provides a lot of convenient methods that are nice and readable, but sometimes you just need (or want) more goodies. The Rails developers created the ActiveSupport library to have more utility methods in your Ruby code.
Since ActiveSupport is adding all those methods using monkey patching, not all Ruby developers like this library. But look at how easy it is on your readability:
Time.now + ( 1 * 60 * 60 )  # => 2018-01-09 10:49:43 +0100
1.hour.from_now             # => 2018-01-09 10:49:43 +0100
1.year.ago                  # => 2017-01-09 09:49:43 +0100
[1,2,3].reduce(:+)                 # => 6
[1,2,3].reduce(:+)                 # => 6
['Earth', 'Wind', 'Fire'].to_sentence # => "Earth, Wind, and Fire"

## Coercion
Have a look a the most permissive coercers:
to_i to convert something to an Integer,
to_s to convert something to a String,
to_f to convert something to a Float
But sometimes you want to go further: you do want to not only be represented as a specific type, you could even be used instead of that type. Think about how the Roman numbers IX, III, XIV represent the integers 9, 3 and 14. Roman numbers could be used as if they were Integers. If your own type could be used instead of an Integer, than you should implement the much stricter to_int method.
The difference between to_i and to_int is this: if your instances respond to to_i, your instance can be represented as an integer. If your instances respond to to_int, your instances could be used whenever an Integer was expected. These strict coercion methods are also available for Strings, Arrays with to_str, to_ary.
Lastly there is another way to coerce objects into other basic Ruby types. It is a very strict coercion, raising Errors if there were problems:
Integer('4.9')    # => `Integer': invalid value for Integer(): "4.9" (ArgumentError)
Float('4.9')      # => 4.9
Hashes and Arrays can both be iterated. Iteration, aka enumeration is a first class citizen in Ruby. Hashes and Arrays have a to_enum method, converting themselves into proper Enumerator objects.

## Comparison
Consider our class that represents T-shirt sizes, from S to XL. The problem is, with only the initializer and to_s we cannot compare sizes in a programmatic way.
We could add five methods for all comparisons we can think of: >, >=, ==, <=, <, so we can check for less-than to greater-than and everything in between.
The Rubyesque way of doing this is different, though. The Comparable module (RTFM) adds all these methods if you just implement 1 method that can drive all above mentioned methods:
That method must return:
-1 if the object is less then to what you compare it to,
0 if both objects are of same size,
1 if the object is greater then what you compare it to.
So that is less-then-or-equal-to-or-greater-than in one go, and you should call it like so:
puts xs <=> xl # this should return -1; since XS is less than XL!
Geek Bonus: Since the comparable module only depends on the spaceship operator, you refactor that method for speed (and/or readability), probably lowering the amount of bugs and quirks in your codebase.

## Enumerating collections
Let’s create a Wardrobe class with an array of @clothes. We want to iterate through the clothes using the each method, and also count them. Too bad! Neither the each nor the count method have been implemented. If we call the each method without any arguments, or without a block of code, we want to just return something that could be iterated, i.e. you have an object that will represent each and every member of your leisure clothes collection. Luckily there is a Enumerator class, and the @clothes array can play the enumerator role perfectly. That means, an array can convert itself to an Enumerator, using the to_enum method. Time to coerce that array into an enumerator:
def each
  @clothes.to_enum
end
Let's pass it a block of code, that we will run for each clothes item in the wardrobe:
Let me show you an example: leisure_clothes.each{ |item| puts item }
So far, though, then enumerator isn't, well, enumerating. The problem is in our implementation. The each method will always and only return an enumerator. It has no implementation that handles a block of code for each element in your collection.
So, the each method returns an enumerator object, whether you call it with a body of code, or without it. It is time to reimplement each, so that it can receive a block of code that will be called for each element of the collection.
class Wardrobe
  def each(&block)
    return @clothes.to_enum unless block
  end
end
First step has succeeded: you have a method that can accept a block. If you don't pass it a block, it will just do what it did before: returning an enumerator. Did you notice that ampersand (&) character? That's Ruby syntax, telling you explicitly that is method can handle a block of code. And we do not have to call it block at all. We could name it anything. But since you can accept at most 1 block of code, and you always have to note that thing with an ampersand, it is convention to just call that thing block.
The thing with blocks of code is: you can call it - meaning you execute that block of code. We could try to print each item of our wardrobe like so:
leisure_clothes.each { |item| puts item }
If we digest that bit of code, we want to go over all items in the leisure_clothes collection, and on each element of that collection call puts for that element. Or in other words, we want to call the block for each element in the collection:
class Wardrobe
  def each(&block)
    return @clothes.to_enum unless block

    @clothes.each do |clothing_item|
      block.call(clothing_item)
    end
  end
end
The first line of that method holds first and simple case: If you do not give it a block to execute, it will just return the clothes instance variable, transformed into an Enumerator: If we do not give the each method a block, we have an enumerator object returned. That means we can call other methods that are available on it:
clothes = leisure_clothes.each  # => #<Enumerator: ...>
clothes.next                    # => "Green T-shirt"
But if there is a block given to the each-method, the second part (after the guard clause) will kick in; it will call that block of code for each instance:
leisure_clothes.each { |item| puts item }

The Enumerable module
Time to dive deeper into Ruby's Standard Library; the Enumerable (RTFM) module that is.
If you have an each method that will call the block for every element of the collection it represents, you can mix in the Enumerable module, getting access to all methods that are defined in it.
This is what the resulting shop class would look like:
class Wardrobe
  include Enumerable

  def initialize(name)
    @name = name
    @clothes = []
  end

  def add_clothes(clothes)
    @clothes << clothes
  end

  def each(&block)
    return @clothes.to_enum unless block

    @clothes.each do |clothing_item|
      block.call(clothing_item)
    end
  end
end

Using the Enumerable module we can call methods like this:
my_wardrobe.count                        # => 3
my_wardrobe.find{|item| item == 'Jeans'} # => "Jeans"
my_wardrobe.map(&:downcase)              # => ["green t-shirt", "yoga pants", "jeans"]
