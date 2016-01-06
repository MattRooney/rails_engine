require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase

  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "#index returns the correct number of transactions" do
    transaction = create(:transaction)
    get :index, format: :json

    assert_equal Transaction.all.count, json_response.count
  end

  test "#index contains transactions that have the correct properties" do
    transaction = create(:transaction)
    get :index, format: :json

    json_response.each do |transaction|
      assert transaction["credit_card_number"]
      assert transaction["result"]
    end
  end

  test "#show responds to json" do
    transaction = create(:transaction)
    get :show, format: :json, id: transaction.id

    assert_response :success
  end

  test "#show returns a hash" do
    transaction = create(:transaction)
    get :show, format: :json, id: transaction.id

    assert_kind_of Hash, json_response
  end

  test "#show contains an transaction with the correct properties" do
    transaction = create(:transaction)
    get :show, format: :json, id: transaction.id

    assert_equal transaction.id, json_response["id"]
    assert_equal transaction.credit_card_number, json_response["credit_card_number"]
    assert_equal transaction.result, json_response["result"]
  end

  test "#find respond to json" do
    transaction = create(:transaction)
    get :find, format: :json, id: transaction.id

    assert_response :success
  end

  test "#find returns a hash" do
    transaction = create(:transaction)
    get :find, format: :json, id: transaction.id

    assert_kind_of Hash, json_response
  end

  test "#find contains a transaction with correct properties" do
    transaction = create(:transaction)
    get :find, format: :json, credit_card_number: transaction.credit_card_number

    assert_equal transaction.id, json_response["id"]
    assert_equal transaction.credit_card_number, json_response["credit_card_number"]
  end

  test "#find_all responds to json" do
    transaction = create(:transaction)
    get :find_all, format: :json, id: transaction.id

    assert_response :success
  end

  test "#find_all returns an array" do
    transaction = create(:transaction)
    get :find_all, format: :json, credit_card_number: transaction.credit_card_number

    assert_kind_of Array, json_response
  end

  test "#find_all contains transactions with correct properties" do
    transaction = create(:transaction)
    get :find_all, format: :json, credit_card_number: transaction.credit_card_number

    assert_equal transaction.id, json_response.first["id"]
  end

  test "#random responds to json" do
    transaction = create(:transaction)
    get :random, format: :json

    assert_response :success
  end

  test "#random returns a single record hash" do
    transaction = create(:transaction)
    get :random, format: :json

    assert_kind_of Hash, json_response
  end

  test "#random returns a transaction with correct properties" do
    transaction = create(:transaction)
    get :random, format: :json

    assert json_response["id"]
    assert json_response["credit_card_number"]
    assert json_response["result"]
  end
end
