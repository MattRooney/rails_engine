require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase

  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of items" do
    item = create(:item)
    get :index, format: :json

    assert_equal Item.all.count, json_response.count
  end

  test "#index contains items that have the correct properties" do
    item = create(:item)
    get :index, format: :json

    json_response.each do |item|
      assert item["name"]
      assert item["description"]
    end
  end

  test "#show responds to json" do
    item = create(:item)
    get :show, format: :json, id: item.id

    assert_response :success
  end

  test "#show returns a hash" do
    item = create(:item)
    get :show, format: :json, id: item.id

    assert_kind_of Hash, json_response
  end

  test "#show contains an item with the correct properties" do
    item = create(:item)
    get :show, format: :json, id: item.id

    assert_equal item.id, json_response["id"]
    assert_equal item.name, json_response["name"]
    assert_equal item.description, json_response["description"]
  end

  test "#find respond to json" do
    item = create(:item)
    get :find, format: :json, id: item.id

    assert_response :success
  end

  test "#find returns a hash" do
    item = create(:item)
    get :find, format: :json, id: item.id

    assert_kind_of Hash, json_response
  end

  test "#find contains a item with correct properties" do
    item = create(:item)
    get :find, format: :json, name: item.name

    assert_equal item.id, json_response["id"]
    assert_equal item.name, json_response["name"]
  end

  test "#find_all responds to json" do
    item = create(:item)
    get :find_all, format: :json, id: item.id

    assert_response :success
  end

  test "#find_all returns an array" do
    item = create(:item)
    get :find_all, format: :json, name: item.name

    assert_kind_of Array, json_response
  end

  test "#find_all contains items with correct properties" do
    item = create(:item)
    get :find_all, format: :json, name: item.name

    assert_equal item.id, json_response.first["id"]
  end

  test "#random responds to json" do
    item = create(:item)
    get :random, format: :json

    assert_response :success
  end

  test "#random returns a single record hash" do
    item = create(:item)
    get :random, format: :json

    assert_kind_of Hash, json_response
  end

  test "#random returns a item with correct properties" do
    item = create(:item)
    get :random, format: :json

    assert json_response["id"]
    assert json_response["name"]
    assert json_response["description"]
  end

  test "#invoice_items responds to json" do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)
    get :invoice_items, format: :json, id: item.id

    assert_response :success
  end

  test "#invoice_items returns an array" do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)
    get :invoice_items, format: :json, id: item.id

    assert_kind_of Array, json_response
  end

  test "#invoice_items returns invoice_items with correct properties" do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)
    get :invoice_items, format: :json, id: item.id

    assert_equal item.id, json_response.first["item_id"]
  end

  test "#merchant responds to json and returns correct merchant" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice_item = create(:invoice_item, item: item)
    get :merchant, format: :json, id: item.id

    assert_response :success
    assert_equal merchant.id, json_response["id"]
  end
 end
