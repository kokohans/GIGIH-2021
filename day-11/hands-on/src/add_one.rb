class AddOne
    def add(arr)

        #step 1
        #[5,6,1]
        

        #step 2
        # arr[-1] += 1
        # if arr[-1] >= 10
        #     arr[-1] = 0
        #     arr[arr.length-2] += 1
        # end

        #arr.reverse
        helper = Array.new(arr[0..-2])
        res = Array.new
        arr[-1]+=1
        carry = 0
        if arr[-1] >= 10
            carry
            arr[-1] = 0
                helper.reverse
                helper.each do | x |
                    if carry == 1
                        x+=1
                        carry = 0
                    end
                    if x >= 10
                        carry = 1
                        x = 0
                    end
                    res << x
                end
        end

        res << arr[-1]
    end
end

add_one = AddOne.new

puts add_one.add([1,2,9])