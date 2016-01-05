require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  def create_invoices
    x = 1
    5.times do
      Invoice.create!(first_name: "first_name #{x}",
                       last_name: "last_name #{x}")
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
    create_invoices
    get :index, format: :json

    assert_equal invoice_count, json_response.count
  end

  test "#index contains invoices that have the correct properties" do
    create_invoices
    get :index, format: :json

    json_response.each do |invoice|
      assert invoice["first_name"]
      assert invoice["last_name"]
    end
  end

  test "#show responds to json" do
    create_invoices
    get :show, format: :json, id: invoice.first.id

    assert_response :success
  end

  test "#show returns a hash" do
    create_invoices
    get :show, format: :json, id: invoice.first.id

    assert_kind_of Hash, json_response
  end

  test "#show contains an invoice with the correct properties" do
    create_invoices
    get :show, format: :json, id: invoice.first.id

    assert invoice.first.id, json_response["id"]
    assert invoice.first.first_name, json_response["first_name"]
    assert invoice.first.last_name, json_response["last_name"]
  end

end
