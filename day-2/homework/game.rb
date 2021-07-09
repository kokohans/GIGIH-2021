require_relative 'heros'
require_relative 'mongols'

class Game

    def initialize
        @jin = Main.new("Jin Sakai", 100, 50, 20, 8)
        @yuna = Allies.new("Yuna", 90, 45)
        @ishikawa = Allies.new("Sensei Ishikawa", 80, 60)

        @mongols1 = Archer.new('Mongol Archer', 100, 40)
        @mongols2 = Spearman.new('Mongol Spearman', 120, 60)
        @mongols3 = Swordman.new('Mongol Swordman', 100, 50)

        @mongols = [@mongols1, @mongols2, @mongols3]
        @allies = [@yuna, @ishikawa]
        @heroes = [@jin, @yuna, @ishikawa]
    end

    def display_char
        puts @jin

        @allies.each do | ally |
            puts ally
        end
        
        puts "\n"
        
        @mongols.each do | mongol |
            puts mongol
        end

        puts "\n"
    end

    def display_mongols
        i = 1
        @mongols.each do | mongol |
            puts "#{i}) #{mongol.name}"
            i += 1
        end
    end
    
    def display_allies
        i = 1
        @allies.each do | ally |
            puts "#{i}) #{ally.name}"
            i += 1
        end

        @allies.length > 0
    end

    def mongol_attack_heros
        @mongols.each do | mongol |
            mongol.attack(@heroes[rand(@heroes.length)])
            clean_allies
        end
    end

    def allies_attack_mongols
        return if @mongols.length <= 0
        @allies.each do | ally |
            ally.attack(@mongols[rand(@mongols.length)])
            clean_mongols
        end
    end

    def jin_attack(attack_to)
        @jin.attack(@mongols[attack_to])
        clean_mongols
    end

    def jin_heal(heal_to)
        @jin.heal(@allies[heal_to])
    end

    def clean_mongols
        if @mongols.length == 0
            return
        end
        @mongols.each do | mongol |
            @mongols.delete(mongol) if mongol.is_died? || mongol.is_fled?
        end
    end

    def clean_allies
        if @allies.length == 0
            return
        end
        @allies.each do | ally |
            if ally.is_died?
                @heroes.delete(ally)
                @allies.delete(ally) 
            end
        end
    end

    def check_battlefield
        @mongols.length <= 0 || @jin.is_died?
    end

end