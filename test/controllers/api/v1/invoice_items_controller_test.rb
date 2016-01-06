require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase

  def create_invoices
    x = 1
    5.times do
      Invoice.create!(status: "status #{x}")
      x += 1
    end
  end

  def invoice_count
    Invoice.count
  end

  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of invoices" do
    skip
    create_invoices
    get :index, format: :json

    assert_equal invoice_count, json_response.count
  end

  test "#index contains invoices that have the correct properties" do
    create_invoices
    get :index, format: :json

    json_response.each do |invoice|
      assert invoice["customer_id"]
      assert invoice["status"]
    end
  end

  test "#show responds to json" do
    create_invoices
    get :show, format: :json, id: Invoice.first.id

    assert_response :success
  end

  test "#show returns a hash" do
    skip
    create_invoices
    get :show, format: :json, id: Invoice.first.id

    assert_kind_of Hash, json_response
  end

  test "#show contains an invoice with the correct properties" do
    skip
    create_invoices
    get :show, format: :json, id: invoice.first.id

    assert invoice.first.id, json_response["id"]
  end

end
