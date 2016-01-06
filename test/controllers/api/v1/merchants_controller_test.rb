require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase

  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of merchants" do
    merchant = create(:merchant)
    get :index, format: :json

    assert_equal Merchant.all.count, json_response.count
  end

  test "#index contains merchants that have the correct properties" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    get :index, format: :json

    json_response.each do |merchant|
      assert merchant["name"]
    end
  end

  test "#show responds to json" do
    merchant = create(:merchant)
    get :show, format: :json, id: merchant.id

    assert_response :success
  end

  test "#show returns a hash" do
    merchant = create(:merchant)
    get :show, format: :json, id: merchant.id

    assert_kind_of Hash, json_response
  end

  test "#show contains an merchant with the correct properties" do
    merchant = create(:merchant)
    get :show, format: :json, id: merchant.id

    assert_equal merchant.id, json_response["id"]
    assert_equal merchant.name, json_response["name"]
  end

  test "#find respond to json" do
    merchant = create(:merchant)
    get :find, format: :json, id: merchant.id

    assert_response :success
  end

  test "#find returns a hash" do
    merchant = create(:merchant)
    get :find, format: :json, id: merchant.id

    assert_kind_of Hash, json_response
  end

  test "#find contains a merchant with correct properties" do
    merchant = create(:merchant)
    get :find, format: :json, name: merchant.name

    assert_equal merchant.id, json_response["id"]
    assert_equal merchant.name, json_response["name"]
  end

  test "#find_all responds to json" do
    merchant = create(:merchant)
    get :find_all, format: :json, id: merchant.id

    assert_response :success
  end

  test "#find_all returns an array" do
    merchant = create(:merchant)
    get :find_all, format: :json, name: merchant.name

    assert_kind_of Array, json_response
  end

  test "#find_all contains merchants with correct properties" do
    merchant = create(:merchant)
    get :find_all, format: :json, name: merchant.name

    assert_equal merchant.id, json_response.first["id"]
  end

  test "#random responds to json" do
    merchant = create(:merchant)
    get :random, format: :json

    assert_response :success
  end

  test "#random returns a single record hash" do
    merchant = create(:merchant)
    get :random, format: :json

    assert_kind_of Hash, json_response
  end

  test "#random returns a merchant with correct properties" do
    merchant = create(:merchant)
    get :random, format: :json

    assert json_response["id"]
    assert json_response["name"]
  end

  test "#items responds to json" do
    merchant = create(:merchant)
    get :items, format: :json, id: merchant.id

    assert_response :success
  end

  test "#items returns an array of items" do
    merchant = create(:merchant)
    get :items, format: :json, id: merchant.id

      assert_kind_of Array, json_response
  end

  test "#items returns correct number of items" do
    merchant = create(:merchant)
    get :items, format: :json, id: merchant.id

    assert_equal merchant.items.count, json_response.count
  end

  test "#items returns items with the correct properties" do
    merchant = create(:merchant)
    items = create(:item, merchant: merchant)
    get :items, format: :json, id: merchant.id
    
    assert_equal merchant.items.first.name,
                 json_response.first["name"]
  end

end
