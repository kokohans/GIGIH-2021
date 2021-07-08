require_relative 'characters'

class Mongols < Characters

    def initialize(name, hitpoint, damage)
        super(name, hitpoint, damage)
        @fled = false
    end

    def take_damage(damage)
        if @hitpoint <= 50
            flee if rand(1..10) > 5 
            return
        end
        @hitpoint -= damage
        if @hitpoint <= 0
            play_dead
            return
        end
    end

    def flee
        puts "#{@name} has fled the battlefield with #{@hitpoint} hitpoint left"
        @fled = true
    end

    def is_fled?
        @fled
    end
end

class Archer < Mongols

    def initialize(name, hitpoint, damage)
        super(name, hitpoint, damage)
    end

    def attack(other_player)
        puts "#{@name} shoot arrow #{other_player.name} with #{@damage} attack damage"
        other_player.take_damage(@damage)
    end
end

class Spearman < Mongols

    def initialize(name, hitpoint, damage)
        super(name, hitpoint, damage)
    end

    def attack(other_player)
        puts "#{@name} thrusts #{other_player.name} with #{@damage} attack damage"
        other_player.take_damage(@damage)
    end
end

class Swordman < Mongols

    def initialize(name, hitpoint, damage)
        super(name, hitpoint, damage)
    end

    def attack(other_player)
        puts "#{@name} slash #{other_player.name} with #{@damage} attack damage"
        other_player.take_damage(@damage)
    end
end
