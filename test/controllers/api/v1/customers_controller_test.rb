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

    assert_equal Customer.all.count, json_response.count
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

  test "#invoices returns an array" do
    customer = create(:customer_with_invoices)
    get :invoices, format: :json, id: customer.id

    assert_kind_of Array, json_response
  end

  test "#invoices returns invoices with correct properties" do
    customer = create(:customer)
    customer.invoices << create(:invoice)
    get :invoices, format: :json, id: customer.id

    assert_equal customer.id, json_response.first["customer_id"]
  end

  test "#transactions responds to json" do
    customer = create(:customer_with_transactions)
    get :transactions, format: :json, id: customer.id

    assert_response :success
  end

  test "#transactions returns an array" do
    customer = create(:customer_with_transactions)
    get :transactions, format: :json, id: customer.id

    assert_kind_of Array, json_response
  end

  test "#transactions returns transactions with correct properties" do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)
    transaction = create(:transaction, invoice: invoice)
    get :transactions, format: :json, id: customer.id

    assert_equal customer.transactions.count, json_response.count
    assert_equal customer.id, Invoice.find(json_response.last["invoice_id"]).customer_id
  end

############ BIZ LOGIC ##########################

  test "#favorite_merchant responds to json" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transaction = create(:transaction, invoice: invoice)
    get :favorite_merchant, format: :json, id: customer.id

    assert_response :success
  end

  test "#favorite_merchant returns the correct merchant" do
    customer = create(:customer)

    merchant      = create(:merchant)
    invoice       = create(:invoice, customer: customer, merchant: merchant)
    invoice_2     = create(:invoice, customer: customer, merchant: merchant)
    invoice_3     = create(:invoice, customer: customer, merchant: merchant)
    invoice_4     = create(:invoice, customer: customer, merchant: merchant)
    transaction   = create(:transaction, invoice: invoice)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)
    transaction_4 = create(:transaction, invoice: invoice_4)

    merchant_2    = create(:merchant, name: "Matt")
    invoice_5     = create(:invoice, customer: customer, merchant: merchant_2)
    invoice_6     = create(:invoice, customer: customer, merchant: merchant_2)
    transaction_5 = create(:transaction, invoice: invoice_5)
    transaction_6 = create(:transaction, invoice: invoice_6)

    get :favorite_merchant, format: :json, id: customer.id

    assert_equal merchant, Merchant.find(json_response["id"])
  end
end
