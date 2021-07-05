require_relative 'player'

jin = Jin.new("Jin Sakai", 100, 50)
puts jin
khotun = Player.new("Khotun Khan",500, 50)
puts khotun
puts ""


loop do 
    jin.attack(khotun)
    puts khotun
    puts ""
    khotun.attack(jin)
    puts jin
    puts ""
    if jin.is_died?
        puts "#{jin.name} dies"
        break
    elsif khotun.is_died?
        puts "#{khotun.name} dies"
        break
    end
end