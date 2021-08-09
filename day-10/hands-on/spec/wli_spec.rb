require_relative '../src/wli'

RSpec.describe WLI do
    it 'Who likes it 2 people' do
        #Given
        name = ["Jacob", "Alex"]
        wli = WLI.new
        wli.names = name
        #When
        wholikesit = wli.likes
        #Then
        expect(wholikesit).to eq("#{name[0]} and #{name[1]} likes this")
    end
    it 'Who likes it 3 people' do
        #Given
        name = ["Jacob", "Alex", "Budy"]
        wli = WLI.new
        wli.names = name
        #When
        wholikesit = wli.likes
        #Then
        expect(wholikesit).to eq("#{name[0]}, #{name[1]}, and #{name[2]} likes this")
    end
    it 'Who likes it 1 person' do
        #Given
        name = ["Jacob", "Alex", "Budy"]
        wli = WLI.new
        wli.names = name
        #When
        wholikesit = wli.likes
        #Then
        expect(wholikesit).to eq("#{name[0]}, #{name[1]}, and #{name[2]} likes this")
    end
    it 'no one likes it' do
        #Given
        name = []
        wli = WLI.new
        wli.names = name
        #When
        wholikesit = wli.likes
        #Then
        expect(wholikesit).to eq("no one likes this")
    end

    it 'one likes it' do
        #Given
        name = ["Budy"]
        wli = WLI.new
        wli.names = name
        #When
        wholikesit = wli.likes
        #Then
        expect(wholikesit).to eq("#{name[0]} likes this")
    end

    it 'no one likes it' do
        #Given
        name = ["Budy"]
        wli = WLI.new
        wli.names = name
        #When
        wholikesit = wli.likes
        #Then
        expect(wholikesit).to eq("#{name[0]} likes this")
    end

    it 'Who likes it 4 people or more ' do
        #Given
        name = ["Budy", "Budi lagi", "Budi aja", "Budi budy"]
        wli = WLI.new
        wli.names = name
        #When
        wholikesit = wli.likes
        #Then
        expect(wholikesit).to eq("#{name[0]}, #{name[1]}, and #{name.length - 2} others like this")
    end
end