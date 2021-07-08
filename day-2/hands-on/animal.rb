class Mammal
    def breathe
        puts "inhale and exhale"
    end
end

class Cat < Mammal
    def speak
        puts "Meow"
    end
end

class Meowth < Cat
    def speak
        puts "make it double"
    end
end

class Bird
    def preen
        puts "I'm cleaning my feathers"
    end

    def fly
        puts "I am flying"
    end

end

class Pinguin < Bird
    def fly
        puts "Sorry. I'd rather swim."
    end
end


class Dog < Mammal
    def initialize(breed)
        @breed = breed
    end

    def breathe
        puts "dog breath"
    end
end

class Lab < Dog
    def initialize(breed, name)
        super(breed)
        @name = name
    end

    def to_s
        "(#@breed, #@name)"
    end

    def fly
        m = Pinguin.instance_method(:fly).bind(self)
        m.call
    end
end

require_relative 'animal'

neko = Cat.new
neko.breathe
neko.speak

pingun = Pinguin.new
pingun.fly
pingun.preen

meowth = Meowth.new
meowth.speak


laby = Lab.new("Labrador", "Benzy")

laby.breathe