require_relative '../src/add_one'

RSpec.describe AddOne do
    it 'returns [5, 6, 1] if passed [5, 6, 0]' do
        add_one = AddOne.new
        arr = [5,6,0]
        result = add_one.add(arr)
        expect(result).to eq([5,6,1])
    end

    it 'returns [4,0] if passed [3,9]' do
        add_one = AddOne.new
        arr = [3,9]
        result = add_one.add(arr)
        expect(result).to eq([4,0])
    end

    it 'returns [1,0,0] if passed [9,9]' do
        add_one = AddOne.new
        arr = [9,9]
        result = add_one.add(arr)
        expect(result).to eq([1,0,0])
    end

    it 'returns [1,0,0,0] if passed [9,9,9]' do
        add_one = AddOne.new
        arr = [9,9,9]
        result = add_one.add(arr)
        expect(result).to eq([1,0,0,0])
    end
end