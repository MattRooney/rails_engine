require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase

  def create_customers
    x = 1
    5.times do
      Customer.create!(first_name: "first_name #{x}",
                       last_name: "last_name #{x}")
      x += 1
    end
  end

  def customer_count
    Customer.count
  end

  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of customers" do
    create_customers
    get :index, format: :json

    assert_equal customer_count, json_response.count
  end

  test "#index contains customers that have the correct properties" do
    create_customers
    get :index, format: :json

    json_response.each do |customer|
      assert customer["first_name"]
      assert customer["last_name"]
    end
  end

  test "#show responds to json" do
    create_customers
    get :show, format: :json, id: Customer.first.id

    assert_response :success
  end

  test "#show returns a hash" do
    create_customers
    get :show, format: :json, id: Customer.first.id

    assert_kind_of Hash, json_response
  end

  test "#show contains an customer with the correct properties" do
    create_customers
    get :show, format: :json, id: Customer.first.id

    assert Customer.first.id, json_response["id"]
    assert Customer.first.first_name, json_response["first_name"]
    assert Customer.first.last_name, json_response["last_name"]
  end

end
