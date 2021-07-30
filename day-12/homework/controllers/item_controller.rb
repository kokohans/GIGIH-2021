require './models/item'
require './models/item_category'
require './models/category'

class ItemController
    def list_items
        items = Item.get_all_items
        renderer = ERB.new(File.read('./views/items.erb'))
        renderer.result(binding)
    end

    def show_items_by_id(params)
        item = Item.get_item_by_id(params['id'])
        categories = Category.get_all_categories
        item.find_categories
        renderer = ERB.new(File.read('./views/item_detail.erb'))
        renderer.result(binding)
    end

    def new_item(params)
        new_item = Item.new(params['name'], params['price'])
        new_id = new_item.save
        params['category'].each do | category |
            new_item_category = Item_category.new(new_id, category)
            new_item_category.save
        end
    end

    def new_item_form
        categories = Category.get_all_categories
        renderer = ERB.new(File.read('./views/item_create.erb'))
        renderer.result(binding)
    end
    def delete_item(params)
        item = Item.get_item_by_id(params['id'])
        item_categories = Item_category.get_categories_by_item_id(item.id)
        item_categories.delete_item
        item.delete
    end

    def update_item(params)
        old_item = Item.get_item_by_id(params['id'])
        old_item_category = Item_category.get_categories_by_item_id(params['id'])
        old_item_category.category_id = params['category']
        old_item.name = params['name']
        old_item.price = params['price']
        old_item.update
        old_item_category.update
    end

    def update_item_form(params)
        item = Item.get_item_by_id(params['id'])
        item.find_categories
        categories = Category.get_all_categories
        if item
            renderer = ERB.new(File.read('./views/item_edit.erb'))
            renderer.result(binding)
        else
            404
        end
    end
end
