require 'test_helper'

class StockListsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get stock_lists_create_url
    assert_response :success
  end

end
