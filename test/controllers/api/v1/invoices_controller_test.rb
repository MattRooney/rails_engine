require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of invoices" do
    invoice = create(:invoice)
    get :index, format: :json

    assert_equal Invoice.all.count, json_response.count
  end

  test "#index contains invoices that have the correct properties" do
    invoice = create(:invoice)
    get :index, format: :json

    json_response.each do |invoice|
      assert invoice["customer_id"]
      assert invoice["merchant_id"]
      assert invoice["status"]
    end
  end

  test "#show responds to json" do
    invoice = create(:invoice)
    get :show, format: :json, id: invoice.id

    assert_response :success
  end

  test "#show returns a hash" do
    invoice = create(:invoice)
    get :show, format: :json, id: invoice.id

    assert_kind_of Hash, json_response
  end

  test "#show contains an invoice with the correct properties" do
    invoice = create(:invoice)
    get :show, format: :json, id: invoice.id

    assert_equal invoice.id, json_response["id"]
    assert_equal invoice.customer_id, json_response["customer_id"]
    assert_equal invoice.status, json_response["status"]
  end

  test "#find respond to json" do
    invoice = create(:invoice)
    get :find, format: :json, id: invoice.id

    assert_response :success
  end

  test "#find returns a hash" do
    invoice = create(:invoice)
    get :find, format: :json, id: invoice.id

    assert_kind_of Hash, json_response
  end

  test "#find contains a invoice with correct properties" do
    invoice = create(:invoice)
    get :find, format: :json, id: invoice.id

    assert_equal invoice.id, json_response["id"]
    assert_equal invoice.customer_id, json_response["customer_id"]
  end

  test "#find_all responds to json" do
    invoice = create(:invoice)
    get :find_all, format: :json, id: invoice.id

    assert_response :success
  end

  test "#find_all returns an array" do
    invoice = create(:invoice)
    get :find_all, format: :json, id: invoice.id

    assert_kind_of Array, json_response
  end

  test "#find_all contains invoices with correct properties" do
    invoice = create(:invoice)
    get :find_all, format: :json, id: invoice.id

    assert_equal invoice.id, json_response.first["id"]
  end

  test "#random responds to json" do
    invoice = create(:invoice)
    get :random, format: :json

    assert_response :success
  end

  test "#random returns a single record hash" do
    invoice = create(:invoice)
    get :random, format: :json

    assert_kind_of Hash, json_response
  end

  test "#random returns a invoice with correct properties" do
    invoice = create(:invoice)
    get :random, format: :json

    assert json_response["id"]
    assert json_response["customer_id"]
    assert json_response["status"]
  end

  test "#invoice_items resopnds to json" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)
    get :invoice_items, format: :json, id: invoice.id

    assert_response :success
  end

  test "#invoice_items returns an array" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)
    get :invoice_items, format: :json, id: invoice.id

    assert_kind_of Array, json_response
  end

  test "#invoice_items returns invoice_items w correct properties" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)

    get :invoice_items, format: :json, id: invoice.id

    assert_equal invoice.id, json_response.first["invoice_id"]
  end

  test "#items responds to json" do
    invoice = create(:invoice)
    item = create(:item)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)

    get :items, format: :json, id: invoice.id

    assert_response :success
  end

  test "#items returns correct items" do
    invoice = create(:invoice)
    item = create(:item)
    item_2 = create(:item, name: "another item")
    invoice_item = create(:invoice_item, invoice: invoice, item: item)
    invoice_item_2 = create(:invoice_item, invoice: invoice, item: item_2)

    get :items, format: :json, id: invoice.id

    assert_equal 2, invoice.items.count
  end

  test "#customer responds to json and returns correct customer" do
    customer = create(:customer)
    customer_2 = create(:customer, first_name: "Matt")
    invoice = create(:invoice, customer_id: customer.id)
    invoice_2 = create(:invoice, customer_id: customer_2.id)

    get :customer, format: :json, id: invoice.id

    assert_response :success
    assert_equal customer.id, json_response["id"]
  end

  test "#merchant responds to json and returns correct merchant" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant, name: "Matt")
    invoice = create(:invoice, merchant_id: merchant.id)
    invoice_2 = create(:invoice, merchant_id: merchant_2.id)

    get :merchant, format: :json, id: invoice.id

    assert_response :success
    assert_equal merchant.id, json_response["id"]
  end

end
