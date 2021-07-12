require_relative 'game'

ghost_of_tsushima = Game.new

game_turn = 1

loop do
    puts "=================Turn #{game_turn}==========="
    ghost_of_tsushima.display_char

    puts "As Jin Sakai, what do you want to do this turn?"
    puts "1) Attack an enemy"
    puts "2) Heal an ally"

    step = gets.to_i

    case step
    when 1
        puts "Which enemy you want to attack?"
        ghost_of_tsushima.display_mongols
        attack_to = gets.to_i - 1

        ghost_of_tsushima.jin_attack(attack_to)

        ghost_of_tsushima.allies_attack_mongols

        ghost_of_tsushima.mongol_attack_heros

    when 2
        
        puts "Which ally you want to heal?"
        if ghost_of_tsushima.display_allies
            heal_to = gets.to_i - 1

            ghost_of_tsushima.jin_heal(heal_to)

            ghost_of_tsushima.allies_attack_mongols

            ghost_of_tsushima.mongol_attack_heros
        else
            puts "No more allies"
            next
        end
    end
    game_turn+=1
    break if ghost_of_tsushima.check_battlefield
    puts "\n"
end