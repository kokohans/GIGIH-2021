class Characters
    attr_reader :name, :damage
	def initialize(name, hitpoint, damage)
		@name, @hitpoint, @damage = name, hitpoint, damage
	end
	
    def to_s
        "#{@name} has #{@hitpoint} hitpoint and #{@damage} attack damage\n"
    end

    def attack(other_player)
        puts "#{@name} attack #{other_player.name} with #{@damage} attack damage"
        other_player.take_damage(@damage)
    end

    def take_damage(damage)
        @hitpoint -= damage
    end

    def is_died?()
        @hitpoint <= 0
    end
end

class Heros < Characters
    def take_damage(damage)
        if rand(1..10) <= 8
            puts "#{@name} deflects the attack"
        else
            @hitpoint -= damage
        end
    end
end
