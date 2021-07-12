require_relative 'characters'

class Main < Characters
    def initialize(name, hitpoint, damage, mp, dodge)
        super(name, hitpoint, damage)
        @mp = mp
        @dodge = dodge
    end

    def take_damage(damage)
        if rand(1..10) <= @dodge
            deflect
        else
            super(damage)
        end
    end

    def deflect
        puts "#{@name} deflects the attack"
    end

    def heal(ally)
        puts "#{@name} heals #{ally.name}, restoring #{@mp} hitpoints"
        ally.take_med(@mp)
    end
end

class Allies < Characters
    def take_med(mp)
        @hitpoint += mp
    end
end