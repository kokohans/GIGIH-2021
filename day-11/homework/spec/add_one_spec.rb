require_relative '../src/add_one'

RSpec.describe AddOne do
    it 'returns [1] if passed [0]' do
        add_one = AddOne.new
        arr = [0]
        result = add_one.add(arr)
        expect(result).to eq([1])
    end

    it 'returns [4] if passed [3]' do
        add_one = AddOne.new
        arr = [3]
        result = add_one.add(arr)
        expect(result).to eq([4])
    end

    it 'returns [4,3] if passed [4,2]' do
        add_one = AddOne.new
        arr = [4,2]
        result = add_one.add(arr)
        expect(result).to eq([4,3])
    end

    it 'returns [5,0] if passed [4,9]' do
        add_one = AddOne.new
        arr = [4,9]
        result = add_one.add(arr)
        expect(result).to eq([5,0])
    end

    it 'returns [5,5,3] if passed [5,5,2]' do
        add_one = AddOne.new
        arr = [5,5,2]
        result = add_one.add(arr)
        expect(result).to eq([5,5,3])
    end

    it 'returns [5,5,0] if passed [5,4,9]' do
        add_one = AddOne.new
        arr = [5,4,9]
        result = add_one.add(arr)
        expect(result).to eq([5,5,0])
    end

    it 'returns [6,0,0] if passed [5,9,9]' do
        add_one = AddOne.new
        arr = [5,9,9]
        result = add_one.add(arr)
        expect(result).to eq([6,0,0])
    end

    it 'returns [4,5,6] if passed [4,5,5]' do
        add_one = AddOne.new
        arr = [4,5,5]
        result = add_one.add(arr)
        expect(result).to eq([4,5,6])
    end

    it 'returns [4,4,5,6] if passed [4,4,5,5]' do
        add_one = AddOne.new
        arr = [4,4,5,5]
        result = add_one.add(arr)
        expect(result).to eq([4,4,5,6])
    end

    it 'returns [4,4,5,0] if passed [4,4,4,9]' do
        add_one = AddOne.new
        arr = [4,4,4,9]
        result = add_one.add(arr)
        expect(result).to eq([4,4,5,0])
    end

    it 'returns [5,0,0,0] if passed [4,9,9,9]' do
        add_one = AddOne.new
        arr = [4,9,9,9]
        result = add_one.add(arr)
        expect(result).to eq([5,0,0,0])
    end

    it 'returns [1,0] if passed [9]' do
        add_one = AddOne.new
        arr = [9]
        result = add_one.add(arr)
        expect(result).to eq([1,0])
    end

    it 'returns [1,0,0] if passed [9,9]' do
        add_one = AddOne.new
        arr = [9,9]
        result = add_one.add(arr)
        expect(result).to eq([1,0,0])
    end
end