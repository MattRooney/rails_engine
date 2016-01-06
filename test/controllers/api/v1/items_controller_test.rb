require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  def create_items
    x = 1
    5.times do
      Item.create!(name: "name #{x}",
                   description: "description #{x}",
                   unit_price: 99.99)
      x += 1
    end
  end

  def item_count
    Item.count
  end

  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of items" do
    create_items
    get :index, format: :json

    assert_equal item_count, json_response.count
  end

  test "#index contains items that have the correct properties" do
    create_items
    get :index, format: :json

    json_response.each do |item|
      assert item["name"]
      assert item["description"]
    end
  end

  test "#show responds to json" do
    create_items
    get :show, format: :json, id: Item.first.id

    assert_response :success
  end

  test "#show returns a hash" do
    create_items
    get :show, format: :json, id: Item.first.id

    assert_kind_of Hash, json_response
  end

  test "#show contains an item with the correct properties" do
    create_items
    get :show, format: :json, id: Item.first.id

    assert_equal Item.first.id, json_response["id"]
    assert_equal Item.first.name, json_response["name"]
    assert_equal Item.first.description, json_response["description"]
  end

  test "#find respond to json" do
    create_items
    get :find, format: :json, id: Item.first.id

    assert_response :success
  end

  test "#find returns a hash" do
    create_items
    get :find, format: :json, id: Item.first.id

    assert_kind_of Hash, json_response
  end

  test "#find contains a item with correct properties" do
    create_items
    get :find, format: :json, name: Item.first.name

    assert_equal Item.first.id, json_response["id"]
    assert_equal Item.first.name, json_response["name"]
  end

  test "#find_all responds to json" do
    create_items
    get :find_all, format: :json, id: Item.first.id

    assert_response :success
  end

  test "#find_all returns an array" do
    create_items
    get :find_all, format: :json, name: Item.first.name

    assert_kind_of Array, json_response
  end

  test "#find_all contains items with correct properties" do
    create_items
    get :find_all, format: :json, name: Item.first.name

    assert_equal Item.first.id, json_response.first["id"]
  end

  test "#random responds to json" do
    create_items
    get :random, format: :json

    assert_response :success
  end

  test "#random returns a single record hash" do
    create_items
    get :random, format: :json

    assert_kind_of Hash, json_response
  end

  test "#random returns a item with correct properties" do
    create_items
    get :random, format: :json

    assert json_response["id"]
    assert json_response["name"]
    assert json_response["description"]
  end
end
