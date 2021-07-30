require './models/category'
require './models/item'
require './models/item_category'

class CategoryController
    def list_categories
        categories = Category.get_all_categories
        renderer = ERB.new(File.read('./views/categories.erb'))
        renderer.result(binding)
    end

    def create_new_category_form
        renderer = ERB.new(File.read('./views/category_create.erb'))
        renderer.result(binding)
    end

    def new_category(params)
        category = Category.new(params['name'])
        category.save
    end

    def list_items_by_category(params)
        category = Category.get_category_by_id(params['category_id'])
        category.find_items
        renderer = ERB.new(File.read('./views/category_items.erb'))
        renderer.result(binding)
    end

    def delete_category(params)
        category = Category.get_category_by_id(params['category_id'])
        item_categories = Item_category.get_categories_by_category_id(params['category_id'])
        if item_categories
            item_categories.delete_category
            category.delete
        else
            category.delete
        end
    end

    def edit_category_form(params)
        category = Category.get_category_by_id(params['category_id'])
        renderer = ERB.new(File.read('./views/category_edit.erb'))
        renderer.result(binding)
    end

    def edit_category(params)
        category = Category.get_category_by_id(params['category_id'])
        category.name = params['name']
        category.update
    end

    def add_new_item_to_category_form(params)
        category = Category.get_category_by_id(params['category_id'])
        items = Item.get_all_items
        renderer = ERB.new(File.read('./views/category_item_add.erb'))
        renderer.result(binding)
    end

    def add_new_item_to_category(params)
        category = Category.get_category_by_id(params['category_id'])
        category.add_item(params['item_id'])
    end
end