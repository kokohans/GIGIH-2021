require_relative '../db/mysql_connector'


class Order
    attr_accessor :reference_no, :customer_name, :date

    def initialize(reference_no, customer_name, date)
        @reference_no = reference_no
        @customer_name = customer_name
        @date = date
    end

    def save
        return false unless valid?
        client = create_db_client
        client.query("INSERT INTO orders(reference_number, customer_name, date) VALUES ('#{@reference_no}', '#{@customer_name}', '#{date}')")
    end

    def valid?
        return false if @reference_no.nil?
        return false if @customer_name.nil?
        return false if @date.nil?
        true
    end

    def self.get_all_orders
        client = create_db_client
        qry_get = client.query("SELECT * FROM orders_d8")
        orders = Array.new
        qry_get.each do | data |
            order = Order.new(data['reference_number'], data['customer_name'], data['date'])
            orders.push(order)
        end
        orders
    end

    def self.update_item(id,name,price,category)
        client = create_db_client
        qry_category = client.query("UPDATE items SET name='#{name}', price=#{price} WHERE id=#{id}")
        qry_category = client.query("UPDATE item_categories SET category_id=#{category} WHERE item_id=#{id}")
    end
end