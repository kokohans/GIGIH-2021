require_relative '../../models/category'

RSpec.describe Category do
    describe '#valid' do
        context 'when initialized with valid input' do
            it 'should return true' do
                category = Category.new("bukan makanan")
                expect(category.valid?).to eq(true)
            end
            it 'should return false' do
                category = Category.new(nil)
                expect(category.valid?).to eq(false)
            end
        end
    end

    describe '#save' do
        context 'when save with valid name' do
            it 'should return id' do
                category = Category.new("bukan makanan")
                id = category.save
                expect(id).to be_an(Integer)
            end

            it 'should return false' do
                category = Category.new(nil)
                id = category.save
                expect(id).to eq(false)
            end
        end
    end
end