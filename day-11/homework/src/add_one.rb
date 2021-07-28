class AddOne

    INCREMENT_VAL = 1

    def add(input)
        input = input.reverse
        curr_index = 0

        input[curr_index] += INCREMENT_VAL
        if input[curr_index] > 9
            input[curr_index] %=10
            curr_index+=1
            input[curr_index] += INCREMENT_VAL
            if input[curr_index] > 9
                input[curr_index] %= 10
                curr_index+=1
                input[curr_index] += INCREMENT_VAL
            end
        end

        input.reverse
    end
end