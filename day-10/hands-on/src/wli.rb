class WLI
    attr_accessor :names

    def likes
        if @names.length >= 4
            "#{@names[0..1].join(', ')}, and #{@names.length - 2} others like this"
        elsif @names.length > 2
            "#{@names[0..-2].join(', ')}, and #{@names[@names.length-1]} likes this"
        elsif @names.length == 1
            "#{@names[0]} likes this"
        elsif @names.length == 0
            "no one likes this"
        else
            "#{@names[0]} and #{@names[1]} likes this"
        end
    end

end
