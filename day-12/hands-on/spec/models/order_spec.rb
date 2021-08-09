require_relative '../../models/order'

RSpec.describe Order do
    describe '#valid' do
        context 'when initialized with valid input' do
            it 'should return true' do
                order = Order.new("123", "Hans Wiranata","2021-07-30")
                expect(order.valid?).to eq(true)
            end
            it 'should return false' do
                order = Order.new("123", "Hans Wiranata",nil)
                expect(order.valid?).to eq(false)
            end
        end
    end
end