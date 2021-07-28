require_relative '../src/string_transformer'

RSpec.describe StringTransformer do
    it 'returns k if passed b' do
        string_transformer = StringTransformer.new

        result = string_transformer.transform('b')
        expect(result).to eq('k')
    end
end