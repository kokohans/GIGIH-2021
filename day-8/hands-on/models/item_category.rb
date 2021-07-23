require_relative '../db/mysql_connector'

class Item_category
    attr_accessor :item_id, :category_id

    def initialize(item_id, category_id)
        @item_id = item_id
        @category_id = category_id
    end

    def self.get_categories_by_item_id(item_id)
        client = create_db_client
        qry_category = client.query("SELECT category_id FROM item_categories WHERE item_id=#{item_id}")
        item_categories = Item_category.new(item_id, qry_category.first['category_id'])
    end

    def save
        return false unless valid?
        client = create_db_client
        client.query("INSERT INTO item_categories VALUES (#{@item_id}, #{@category_id})")
    end

    def update
        client = create_db_client
        qry_category = client.query("UPDATE item_categories SET category_id=#{@category_id} WHERE item_id=#{@item_id}")
    end

    def delete
        client = create_db_client
        qry_category = client.query("DELETE FROM item_categories WHERE item_id=#{@item_id}")
    end

    def valid?
        return false if @item_id.nil?
        return false if @category_id.nil?
        true
    end
end