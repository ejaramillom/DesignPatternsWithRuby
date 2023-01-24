# use this pattern when creating composite trees or families ob complex objects that change slightly in its configuration

class Builder
  # @abstract definition of part a
  def produce_part_a
    raise NotImplementedError, "#{self.class} has not implemented #{__method__}"
  end

  # @abstract definition of part b
  def produce_part_b
    raise NotImplementedError, "#{self.class} has not implemented #{__method__}"
  end

  # @abstract definition of part c
  def produce_part_c
    raise NotImplementedError, "#{self.class} has not implemented #{__method__}"
  end
end

class ConcreteBuilder1 < Builder
  def initialize
    reset
  end

  def reset
    @product = Product1.new
  end

  def product
    product = @product
    reset
    product
  end

  def produce_part_a
    @product.add('PartA1')
  end

  def produce_part_b
    @product.add('PartB1')
  end

  def produce_part_c
    @product.add('PartC1')
  end
end

class Product1
  def initialize
    @parts = []
  end

  # @param [String] part
  def add(part)
    @parts << part
  end

  def list_parts
    puts "Product parts: #{@parts.join(', ')}"
  end
end

class Director
  attr :builder, true

  def initialize
    @builder = nil
  end

  attr_writer :builder

  def build_minimal_viable_product
    @builder.produce_part_a
  end

  def build_full_featured_product
    @builder.produce_part_a
    @builder.produce_part_b
    @builder.produce_part_c
  end
end

director = Director.new
builder = ConcreteBuilder1.new
director.builder = builder

puts 'Standard basic product: '
director.build_minimal_viable_product
builder.product.list_parts

puts '\n\n'

puts 'Standard full featured product: '
director.build_full_featured_product
builder.product.list_parts

puts '\n\n'

# the builder pattern can be used without a director class

puts 'Custom product: '
builder.produce_part_a
builder.produce_part_b
builder.product.list_parts
