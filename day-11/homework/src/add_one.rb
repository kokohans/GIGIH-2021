class AddOne

    LAST_INDEX = -1
    INCREMENT_VAL = 1

    def add(input)
        input = input.reverse

        input[0] += 1
        if input[0] > 9
            input[0] %=10
            input[1] += 1
            if input[1] > 9
                input[1] %= 10
                input[2] += 1
            end
        end

        input.reverse
    end
end