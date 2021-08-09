require_relative '../../controllers/category_controller'

describe CategoryController do
    describe '#show' do
        it 'should show category' do
            controllers = CategoryController.new

            response = controllers.list_categories

            expected_view = ERB.new(File.read("./views/categories.erb")).result_with_hash({
                
            })
            expect(response).to eq(expected_view)
        end
    end
end