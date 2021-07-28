class AddOne

    INCREMENT_VAL = 1

    def add(input)
        input = input.reverse
        curr_index = 0

        input[curr_index] += INCREMENT_VAL

        while input[curr_index] > 9 && curr_index <= input.length
            input[curr_index] %= 10
            curr_index+=1
            if curr_index >= input.length
                input.push(1)
                break
            end
            input[curr_index] += INCREMENT_VAL
        end

        input.reverse
    end
end