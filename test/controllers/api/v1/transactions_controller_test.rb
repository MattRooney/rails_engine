require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase

  def create_transactions
    x = 1
    5.times do
      Transaction.create!(credit_card_number: "credit_card_number #{x}",
                       result: "result #{x}")
      x += 1
    end
  end

  def transaction_count
    Transaction.count
  end

  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of transactions" do
    create_transactions
    get :index, format: :json

    assert_equal transaction_count, json_response.count
  end

  test "#index contains transactions that have the correct properties" do
    create_transactions
    get :index, format: :json

    json_response.each do |transaction|
      assert transaction["credit_card_number"]
      assert transaction["result"]
    end
  end

  test "#show responds to json" do
    create_transactions
    get :show, format: :json, id: Transaction.first.id

    assert_response :success
  end

  test "#show returns a hash" do
    create_transactions
    get :show, format: :json, id: Transaction.first.id

    assert_kind_of Hash, json_response
  end

  test "#show contains an transaction with the correct properties" do
    create_transactions
    get :show, format: :json, id: Transaction.first.id

    assert_equal Transaction.first.id, json_response["id"]
    assert_equal Transaction.first.credit_card_number, json_response["credit_card_number"]
    assert_equal Transaction.first.result, json_response["result"]
  end

  test "#find respond to json" do
    create_transactions
    get :find, format: :json, id: Transaction.first.id

    assert_response :success
  end

  test "#find returns a hash" do
    create_transactions
    get :find, format: :json, id: Transaction.first.id

    assert_kind_of Hash, json_response
  end

  test "#find contains a transaction with correct properties" do
    create_transactions
    get :find, format: :json, credit_card_number: Transaction.first.credit_card_number

    assert_equal Transaction.first.id, json_response["id"]
    assert_equal Transaction.first.credit_card_number, json_response["credit_card_number"]
  end

  test "#find_all responds to json" do
    create_transactions
    get :find_all, format: :json, id: Transaction.first.id

    assert_response :success
  end

  test "#find_all returns an array" do
    create_transactions
    get :find_all, format: :json, credit_card_number: Transaction.first.credit_card_number

    assert_kind_of Array, json_response
  end

  test "#find_all contains transactions with correct properties" do
    create_transactions
    get :find_all, format: :json, credit_card_number: Transaction.first.credit_card_number

    assert_equal Transaction.first.id, json_response.first["id"]
  end

  test "#random responds to json" do
    create_transactions
    get :random, format: :json

    assert_response :success
  end

  test "#random returns a single record hash" do
    create_transactions
    get :random, format: :json

    assert_kind_of Hash, json_response
  end

  test "#random returns a transaction with correct properties" do
    create_transactions
    get :random, format: :json

    assert json_response["id"]
    assert json_response["credit_card_number"]
    assert json_response["result"]
  end
end
