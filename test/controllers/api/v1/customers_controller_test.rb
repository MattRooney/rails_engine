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

    assert_equal Customer.first.id, json_response["id"]
    assert_equal Customer.first.first_name, json_response["first_name"]
    assert_equal Customer.first.last_name, json_response["last_name"]
  end

  test "#find respond to json" do
    create_customers
    get :find, format: :json, id: Customer.first.id

    assert_response :success
  end

  test "#find returns a hash" do
    create_customers
    get :find, format: :json, id: Customer.first.id

    assert_kind_of Hash, json_response
  end

  test "#find contains a customer with correct properties" do
    create_customers
    get :find, format: :json, first_name: Customer.first.first_name

    assert_equal Customer.first.id, json_response["id"]
    assert_equal Customer.first.first_name, json_response["first_name"]
  end

  test "#find_all responds to json" do
    create_customers
    get :find_all, format: :json, id: Customer.first.id

    assert_response :success
  end

  test "#find_all returns an array" do
    create_customers
    get :find_all, format: :json, first_name: Customer.first.first_name

    assert_kind_of Array, json_response
  end

  test "#find_all contains customers with correct properties" do
    create_customers
    get :find_all, format: :json, first_name: Customer.first.first_name

    assert_equal Customer.first.id, json_response.first["id"]
  end

  test "#random responds to json" do
    create_customers
    get :random, format: :json

    assert_response :success
  end

  test "#random returns a single record hash" do
    create_customers
    get :random, format: :json

    assert_kind_of Hash, json_response
  end

  test "#random returns a customer with correct properties" do
    create_customers
    get :random, format: :json

    assert json_response["id"]
    assert json_response["first_name"]
    assert json_response["last_name"]
  end
end
