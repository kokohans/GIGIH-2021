class AddOne

    LAST_INDEX = -1
    INCREMENT_VAL = 1

    def add(input)
        input[LAST_INDEX] += INCREMENT_VAL
        if input[LAST_INDEX] > 9
            input[LAST_INDEX] %= 10
            input[-2] += INCREMENT_VAL
        end
        input
    end
end