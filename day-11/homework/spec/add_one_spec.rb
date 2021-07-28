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
end