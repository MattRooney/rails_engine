require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  def create_merchants
    x = 1
    5.times do
      merchant = Merchant.create!(name: " merchant name #{x}")
      merchant.items.create!(name: "#{x}",
                             description: "description #{x}",
                             unit_price: 9999)
      x += 1
    end
  end

  def merchant_count
    Merchant.count
  end

  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of merchants" do
    create_merchants
    get :index, format: :json

    assert_equal merchant_count, json_response.count
  end

  test "#index contains merchants that have the correct properties" do
    create_merchants
    get :index, format: :json

    json_response.each do |merchant|
      assert merchant["name"]
    end
  end

  test "#show responds to json" do
    create_merchants
    get :show, format: :json, id: Merchant.first.id

    assert_response :success
  end

  test "#show returns a hash" do
    create_merchants
    get :show, format: :json, id: Merchant.first.id

    assert_kind_of Hash, json_response
  end

  test "#show contains an merchant with the correct properties" do
    create_merchants
    get :show, format: :json, id: Merchant.first.id

    assert_equal Merchant.first.id, json_response["id"]
    assert_equal Merchant.first.name, json_response["name"]
  end

  test "#find respond to json" do
    create_merchants
    get :find, format: :json, id: Merchant.first.id

    assert_response :success
  end

  test "#find returns a hash" do
    create_merchants
    get :find, format: :json, id: Merchant.first.id

    assert_kind_of Hash, json_response
  end

  test "#find contains a merchant with correct properties" do
    create_merchants
    get :find, format: :json, name: Merchant.first.name

    assert_equal Merchant.first.id, json_response["id"]
    assert_equal Merchant.first.name, json_response["name"]
  end

  test "#find_all responds to json" do
    create_merchants
    get :find_all, format: :json, id: Merchant.first.id

    assert_response :success
  end

  test "#find_all returns an array" do
    create_merchants
    get :find_all, format: :json, name: Merchant.first.name

    assert_kind_of Array, json_response
  end

  test "#find_all contains merchants with correct properties" do
    create_merchants
    get :find_all, format: :json, name: Merchant.first.name

    assert_equal Merchant.first.id, json_response.first["id"]
  end

  test "#random responds to json" do
    create_merchants
    get :random, format: :json

    assert_response :success
  end

  test "#random returns a single record hash" do
    create_merchants
    get :random, format: :json

    assert_kind_of Hash, json_response
  end

  test "#random returns a merchant with correct properties" do
    create_merchants
    get :random, format: :json

    assert json_response["id"]
    assert json_response["name"]
  end

  test "#items responds to json" do
    create_merchants
    get :items, format: :json, id: Merchant.first.id

    assert_response :success
  end

  test "#items returns an array of items" do
    create_merchants
    get :items, format: :json, id: Merchant.first.id

      assert_kind_of Array, json_response
  end

  test "#items returns correct number of items" do
    create_merchants
    get :items, format: :json, id: Merchant.first.id

    assert_equal Merchant.first.items.count, json_response.count
  end

  test "#items returns items with the correct properties" do
    create_merchants
    get :items, format: :json, id: Merchant.first.id

    assert_equal Merchant.first.items.first.name,
                 json_response.first["name"]
  end

end
