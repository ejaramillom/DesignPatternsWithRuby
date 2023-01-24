# factory method replaces the need to create new objects from classes such as: object = Class.new()

class Creator
  def factory_method
    raise NotImplementedError, "#{self.class} has not implemented method #{__method__}"
  end

  def main_operation
    product = factory_method
    result = "Creator: the same creator's code has just worked with #{product.operation}"
    result
  end
end

# Concrete creator overrides the creator method in order to change the products type

class ConcreteCreatorOne < Creator
  def factory_method
    ConcreteProductOne.new
  end
end

class ConcreteCreatorTwo < Creator
  # @return [ConcreteProductTwo]

  def factory_method
    ConcreteProductTwo.new
  end
end

class Product
  # return [String]
  def operation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteProductOne < Product
  def  operation 
    '{Result of ConcreteProductOne}'
  end
end

class ConcreteProductTwo < Product
  def  operation 
    '{Result of ConcreteProductTwo}'
  end
end

# The client code works with an instance of a concrete creator, albeit through
# its base interface. As long as the client keeps working with the creator via
# the base interface, you can pass it any creator's subclass.

def client_code(creator)
  puts "Client: i'm not aware of the creator's class, but it still works"
  puts "#{creator.main_operation}"
end

puts "App: launched with the concrete creator one"
client_code(ConcreteCreatorOne.new)
puts "\n\n"

puts "App: Launched with the concrete creator two"
client_code(ConcreteCreatorTwo.new)