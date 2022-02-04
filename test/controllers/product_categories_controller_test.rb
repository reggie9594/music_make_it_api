require "test_helper"

class ProductCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get product_categories_create_url
    assert_response :success
  end
end
