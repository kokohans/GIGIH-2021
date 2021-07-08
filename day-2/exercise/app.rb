require_relative 'characters'
require_relative 'mongols'

jin = Heros.new("Jin Sakai", 100, 50)
puts jin
# khotun = Characters.new("Khotun Khan",500, 50)
# puts khotun
# puts ""

mongols1 = Archer.new('Mongol Archer', 100, 40)
mongols2 = Spearman.new('Mongol Spearman', 120, 60)
mongols3 = Swordman.new('Mongol Swordman', 100, 50)

puts mongols1
puts mongols2
puts mongols3

puts "\n"

mongols = [mongols1, mongols2, mongols3]

turn = 1

# mongols.delete(mongols[0]) if mongols[0].is_died? || mongols[0].is_flee?

# puts mongols.length

loop do 

    puts "=================Turn #{turn}==========="

    jin.attack(mongols[rand(mongols.length)])
    
    mongols.each do | mongol |
        mongols.delete(mongol) if mongol.is_died? || mongol.is_fled?
    end

    # mongols.each do | mongol |
    #     puts mongol
    # end

    mongols.each do | mongol |
        mongol.attack(jin)
    end
    puts jin

    if mongols.length == 0
        puts "No more mongols here"
        puts jin
        break
    elsif jin.is_died?
        puts "Jin dies"
        break
    end

    puts "\n"
    turn+=1
end