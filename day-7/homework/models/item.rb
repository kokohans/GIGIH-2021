class Item
    attr_reader :id, :name, :price, :category

    def initialize(id, name, price, caterogy=nil)
        @id = id
        @name = name
        @price = price
        @category = caterogy
    end
end
