class AbstractFactory
  def create_product_a
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def create_product_b
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteFactoryOne < AbstractFactory
  def create_product_a
    ConcreteProductAOne.new
  end

  def create_product_b
    ConcreteProductBOne.new
  end
end

class ConcreteFactoryTwo < AbstractFactory
  def create_product_a
    ConcreteProductATwo.new
  end

  def create_product_b
    ConcreteProductBTwo.new
  end
end

class AbstractProductA
  def useful_method_a
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class AbstractProductB
  def useful_method_b
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def another_useful_method_b(_collaborator)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteProductAOne < AbstractProductA
  def useful_method_a
    'The result of concrete product a one'
  end
end

class ConcreteProductATwo < AbstractProductA
  def useful_method_a
    'The result of concrete product a two'
  end
end

class ConcreteProductBOne < AbstractProductB
  def useful_method_b
    'The result of concrete product b one'
  end

  def another_useful_method_b(collaborator)
    result = collaborator.useful_method_a
    "the result of b one collaborating with (#{result})"
  end
end

class ConcreteProductBTwo < AbstractProductB
  def useful_method_b
    'The result of concrete product b two'
  end

  def another_useful_method_b(collaborator)
    result = collaborator.useful_method_a
    "the result of b two collaborating with (#{result})"
  end
end 

def client_code(factory)
  product_a = factory.create_product_a
  product_b = factory.create_product_b

  puts product_b.useful_method_b.to_s
  puts product_b.another_useful_method_b(product_a).to_s
end 

puts 'Client: Testing client code with the first factory type:'
client_code(ConcreteFactoryOne.new)

puts "\n"

puts 'Client: Testing the same client code with the second factory type:'
client_code(ConcreteFactoryTwo.new)