require_relative '../src/martabak'

RSpec.describe Martabak do
    it 'is delicious' do
        #Given
        martabak = Martabak.new("cokelat")
        #When
        taste = martabak.taste
        #Then
        expect(taste).to eq("martabak cokelat is delicious")
    end

    it 'keju is delicious' do
        #Given
        martabak = Martabak.new("keju")
        #When
        taste = martabak.taste
        #Then
        expect(taste).to eq("martabak keju is delicious")
    end
end