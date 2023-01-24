# an object that supports cloning is knonw as a prototype

class Prototype
  attr_accessor :primitive, :component, :circular_reference
  
  def initialize
    @primivite = nil
    @component = nil
    @circular_reference = nil 
  end 

  def clone
    @component = deep_copy(@component)
    @circular_reference = deep_copy(@circular_reference)
    @circular_reference.prototype = self
    deep_copy(self)
  end 

  private

  def deep_copy(thing)
    Marshal.load(Marshal.dump(thing))
  end 

  # in real applications use a different gem because masrhalling is slow and bad
end 

class ComponentWithbackreference
  attr :prototype, true

  def initialize(prototype)
    @prototype = prototype
  end 
end

p1 = Prototype.new
p1.primitive = 245
p1.component = Time.now
p1.circular_reference = ComponentWithbackreference.new(p1)

p2 = p1.clone

if p1.primitive == p2.primitive
  puts 'Primitive field values have been carried over to a clone. Yay!'
else
  puts 'Primitive field values have not been copied. Booo!'
end

if p1.component.equal?(p2.component)
  puts 'Simple component has not been cloned. Booo!'
else
  puts 'Simple component has been cloned. Yay!'
end

if p1.circular_reference.equal?(p2.circular_reference)
  puts 'Component with back reference has not been cloned. Booo!'
else
  puts 'Component with back reference has been cloned. Yay!'
end

if p1.circular_reference.prototype.equal?(p2.circular_reference.prototype)
  print 'Component with back reference is linked to original object. Booo!'
else
  print 'Component with back reference is linked to the clone. Yay!'
end