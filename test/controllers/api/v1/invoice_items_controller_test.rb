require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase

  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of invoices_item" do
    invoice_item = create(:invoice_item)
    get :index, format: :json

    assert_equal InvoiceItem.count, json_response.count
  end

  test "#index contains invoices that have the correct properties" do
    invoice_item = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)

    get :index, format: :json

    json_response.each do |invoice_item|
      assert invoice_item["invoice_id"]
      assert invoice_item["unit_price"]
    end
  end

  test "#show responds to json" do
    invoice_item = create(:invoice_item)
    get :show, format: :json, id: Invoice.first.id

    assert_response :success
  end

  test "#show returns a hash" do
    invoice_item = create(:invoice_item)
    get :show, format: :json, id: invoice_item.id

    assert_kind_of Hash, json_response
  end

  test "#show contains an invoice with the correct properties" do
    invoice_item = create(:invoice_item)
    get :show, format: :json, id: invoice_item.id

    assert invoice_item.id, json_response["id"]
  end

  test "#find responds to json and returns correct invoice item" do
    invoice_item = create(:invoice_item, quantity: 3434)
    get :find, format: :json, id: invoice_item.id

    assert_response :success
    assert_equal 3434, json_response["quantity"]
  end

end
