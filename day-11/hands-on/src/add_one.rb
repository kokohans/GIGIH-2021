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


        arr[-1] += 1
        if arr[-1] >= 10
            arr[-1] = 0
            arr[arr.length-2] += 1
        end
        if arr[0] >= 10
            arr.unshift(1)
        end
        if arr[1] >= 10
            arr[1] = 0
        end
        arr
    end
end