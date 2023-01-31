class Target
  def request
    "Target: The default target's behavior"
  end 
end 

class Adaptee
  # here we can put useful behavior we need in our code
  def specific_request
    ".eetpadA eht fo roivaheb laicepS"
  end  
end 

class Adapter < Target
  def initialize(adaptee)
    @adaptee = adaptee
  end 

  def request
    "Adapter: (TRASLATED) #{@adaptee.specific_request.reverse!}"
  end 
end 

def client_code(target)
  print target.request
end 

puts 'Client: I can work just fine with the Target objects:'
target = Target.new
client_code(target)
puts "\n\n"

adaptee = Adaptee.new
puts 'Client: The Adaptee class has a weird interface. See, I don\'t understand it:'
puts "Adaptee: #{adaptee.specific_request}"
puts "\n"

puts 'Client: But I can work with it via the Adapter:'
adapter = Adapter.new(adaptee)
client_code(adapter)