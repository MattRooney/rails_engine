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

  test "#revenue responds to json" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice  = create(:invoice, customer: customer, merchant: merchant)
    item     = create(:item)
    invoice_item  = create(:invoice_item, invoice: invoice, item: item)
    transaction   = create(:transaction, invoice: invoice)

    get :revenue, format: :json, id: merchant.id

    assert_response :success
  end

  test "#revenue responds with correct revenue" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice  = create(:invoice, customer: customer, merchant: merchant)
    item     = create(:item)
    invoice_item  = create(:invoice_item, invoice: invoice, item: item)
    transaction   = create(:transaction, invoice: invoice)

    get :revenue, format: :json, id: merchant.id

    assert_equal( {"revenue" => "19.98"}, json_response )
  end

  test "#most_revenue responds with json" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant, name: "Matt")
    customer = create(:customer)

    invoice       = create(:invoice, customer: customer, merchant: merchant)
    invoice_2     = create(:invoice, customer: customer, merchant: merchant)
    invoice_3     = create(:invoice, customer: customer, merchant: merchant)
    invoice_4     = create(:invoice, customer: customer, merchant: merchant)
    item          = create(:item)
    item_2        = create(:item, name: "item 2")
    item_3        = create(:item, name: "item 3")
    item_4        = create(:item, name: "item_4")
    invoice_item  = create(:invoice_item, invoice: invoice, item: item)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_3)
    invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_4)
    transaction   = create(:transaction, invoice: invoice)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)
    transaction_4 = create(:transaction, invoice: invoice_4)

    invoice_5     = create(:invoice, customer: customer, merchant: merchant_2)
    item_5        = create(:item, name: "item 5")
    invoice_item_5 = create(:invoice_item, invoice: invoice_5, item: item_5)
    transaction_5 = create(:transaction, invoice: invoice_5)

    get :most_revenue, format: :json

    assert_response :success
  end

  test "#most_revenue returns the correct revenue" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant, name: "Matt")
    customer = create(:customer)

    invoice       = create(:invoice, customer: customer, merchant: merchant)
    invoice_2     = create(:invoice, customer: customer, merchant: merchant)
    invoice_3     = create(:invoice, customer: customer, merchant: merchant)
    invoice_4     = create(:invoice, customer: customer, merchant: merchant)
    item          = create(:item)
    item_2        = create(:item, name: "item 2")
    item_3        = create(:item, name: "item 3")
    item_4        = create(:item, name: "item_4")
    invoice_item  = create(:invoice_item, invoice: invoice, item: item)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_3)
    invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_4)
    transaction   = create(:transaction, invoice: invoice)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)
    transaction_4 = create(:transaction, invoice: invoice_4)

    invoice_5     = create(:invoice, customer: customer, merchant: merchant_2)
    item_5        = create(:item, name: "item 5")
    invoice_item_5 = create(:invoice_item, invoice: invoice_5, item: item_5)
    transaction_5 = create(:transaction, invoice: invoice_5)

    get :most_revenue, format: :json, quantity: 3

    assert_equal 3, json_response.count
    assert_equal merchant.id, json_response.first["id"]
  end

  test "#most_items returns the correct revenue" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant, name: "Matt")
    customer = create(:customer)

    invoice       = create(:invoice, customer: customer, merchant: merchant)
    invoice_2     = create(:invoice, customer: customer, merchant: merchant)
    invoice_3     = create(:invoice, customer: customer, merchant: merchant)
    invoice_4     = create(:invoice, customer: customer, merchant: merchant)
    item          = create(:item)
    item_2        = create(:item, name: "item 2")
    item_3        = create(:item, name: "item 3")
    item_4        = create(:item, name: "item_4")
    invoice_item  = create(:invoice_item, invoice: invoice, item: item)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_3)
    invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_4)
    transaction   = create(:transaction, invoice: invoice)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)
    transaction_4 = create(:transaction, invoice: invoice_4)

    invoice_5     = create(:invoice, customer: customer, merchant: merchant_2)
    item_5        = create(:item, name: "item 5")
    invoice_item_5 = create(:invoice_item, invoice: invoice_5, item: item_5)
    transaction_5 = create(:transaction, invoice: invoice_5)

    get :most_items, format: :json, quantity: 3

    assert_equal 3, json_response.count
    assert_equal merchant.id, json_response.first["id"]
  end

  test "#favorite_customer responds to json" do
    merchant = create(:merchant)
    customer = create(:customer)
    customer_2 = create(:customer, first_name: "Mick")

    invoice       = create(:invoice, customer: customer, merchant: merchant)
    invoice_2     = create(:invoice, customer: customer, merchant: merchant)
    invoice_3     = create(:invoice, customer: customer, merchant: merchant)
    invoice_4     = create(:invoice, customer: customer, merchant: merchant)
    item          = create(:item)
    item_2        = create(:item, name: "item 2")
    item_3        = create(:item, name: "item 3")
    item_4        = create(:item, name: "item_4")
    invoice_item  = create(:invoice_item, invoice: invoice, item: item)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_3)
    invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_4)
    transaction   = create(:transaction, invoice: invoice)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)
    transaction_4 = create(:transaction, invoice: invoice_4)

    invoice_5     = create(:invoice, customer: customer_2, merchant: merchant)
    item_5        = create(:item, name: "item 5")
    invoice_item_5 = create(:invoice_item, invoice: invoice_5, item: item_5)
    transaction_5 = create(:transaction, invoice: invoice_5)

    get :favorite_customer, format: :json, id: merchant.id

    assert_response :success
  end

  test "#favorite_customer returns correct customer" do
    merchant = create(:merchant)
    customer = create(:customer)
    customer_2 = create(:customer, first_name: "Mick")

    invoice       = create(:invoice, customer: customer, merchant: merchant)
    invoice_2     = create(:invoice, customer: customer, merchant: merchant)
    invoice_3     = create(:invoice, customer: customer, merchant: merchant)
    invoice_4     = create(:invoice, customer: customer, merchant: merchant)
    item          = create(:item)
    item_2        = create(:item, name: "item 2")
    item_3        = create(:item, name: "item 3")
    item_4        = create(:item, name: "item_4")
    invoice_item  = create(:invoice_item, invoice: invoice, item: item)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_3)
    invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_4)
    transaction   = create(:transaction, invoice: invoice)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)
    transaction_4 = create(:transaction, invoice: invoice_4)

    invoice_5     = create(:invoice, customer: customer_2, merchant: merchant)
    item_5        = create(:item, name: "item 5")
    invoice_item_5 = create(:invoice_item, invoice: invoice_5, item: item_5)
    transaction_5 = create(:transaction, invoice: invoice_5)

    get :favorite_customer, format: :json, id: merchant.id

    assert_equal customer.id, json_response["id"]
  end

  test "#customers_with_pending_invoices returns correct customer" do
    merchant = create(:merchant)
    customer = create(:customer)
    customer_2 = create(:customer, first_name: "Mick")

    invoice       = create(:invoice, customer: customer, merchant: merchant)
    invoice_2     = create(:invoice, customer: customer, merchant: merchant)
    invoice_3     = create(:invoice, customer: customer_2, merchant: merchant)
    invoice_4     = create(:invoice, customer: customer_2, merchant: merchant)
    item          = create(:item)
    item_2        = create(:item, name: "item 2")
    item_3        = create(:item, name: "item 3")
    item_4        = create(:item, name: "item_4")
    invoice_item  = create(:invoice_item, invoice: invoice, item: item)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2)
    invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_3)
    invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_4)
    transaction   = create(:transaction, invoice: invoice)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)
    transaction_4 = create(:transaction, invoice: invoice_4, result: "failed")

    get :customers_with_pending_invoices, format: :json, id: merchant.id

    assert_equal customer_2.id, json_response.first["id"]
  end


end
