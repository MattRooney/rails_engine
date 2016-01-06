require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase

  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of customers" do
    customer = create(:customer)
    customer_2 = create(:customer)
    get :index, format: :json

    assert_equal 2, json_response.count
  end

  test "#index contains customers that have the correct properties" do
    customer = create(:customer)
    get :index, format: :json

    json_response.each do |customer|
      assert customer["first_name"]
      assert customer["last_name"]
    end
  end

  test "#show responds to json" do
    customer = create(:customer)
    get :show, format: :json, id: customer.id

    assert_response :success
  end

  test "#show returns a hash" do
    customer = create(:customer)
    get :show, format: :json, id: customer.id

    assert_kind_of Hash, json_response
  end

  test "#show contains an customer with the correct properties" do
    customer = create(:customer)
    get :show, format: :json, id: customer.id

    assert_equal customer.id, json_response["id"]
    assert_equal customer.first_name, json_response["first_name"]
    assert_equal customer.last_name, json_response["last_name"]
  end

  test "#find respond to json" do
    customer = create(:customer)
    get :find, format: :json, id: customer.id

    assert_response :success
  end

  test "#find returns a hash" do
    customer = create(:customer)
    get :find, format: :json, id: customer.id

    assert_kind_of Hash, json_response
  end

  test "#find contains a customer with correct properties" do
    customer = create(:customer)
    get :find, format: :json, first_name: customer.first_name

    assert_equal customer.id, json_response["id"]
    assert_equal customer.first_name, json_response["first_name"]
  end

  test "#find_all responds to json" do
    customer = create(:customer)
    get :find_all, format: :json, id: customer.id

    assert_response :success
  end

  test "#find_all returns an array" do
    customer = create(:customer)
    get :find_all, format: :json, first_name: customer.first_name

    assert_kind_of Array, json_response
  end

  test "#find_all contains customers with correct properties" do
    customer = create(:customer)
    get :find_all, format: :json, first_name: customer.first_name

    assert_equal customer.id, json_response.first["id"]
  end

  test "#random responds to json" do
    customer = create(:customer)
    get :random, format: :json

    assert_response :success
  end

  test "#random returns a single record hash" do
    customer = create(:customer)
    get :random, format: :json

    assert_kind_of Hash, json_response
  end

  test "#random returns a customer with correct properties" do
    customer = create(:customer)
    get :random, format: :json

    assert json_response["id"]
    assert json_response["first_name"]
    assert json_response["last_name"]
  end

  test "#invoices responds to json" do
    customer = create(:customer_with_invoices)
    get :invoices, format: :json, id: customer.id

    assert_response :success
  end
end
