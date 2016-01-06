class Api::V1::CustomersController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(customer_params)
  end

  def find
    respond_with Customer.find_by(customer_params)
  end

  def find_all
    respond_with Customer.where(customer_params)
  end

  def random
    respond_with Customer.random
  end

  def invoices
    respond_with Customer.find_by(customer_params).invoices
  end

  def transactions
    respond_with Customer.find_by(customer_params).transactions
  end

  def favorite_merchant
    invoice_ids = Customer.find(params[:id]).transactions.where(result: "success").pluck(:invoice_id)
    merchant_ids = Invoice.find(invoice_ids).map { |invoice| invoice.merchant_id }
    freq = merchant_ids.inject(Hash.new(0)) { |hash,value| hash[value] += 1; hash }
    favorite_merchant_id = merchant_ids.max_by{ |value| freq[value] }
    respond_with Merchant.find(favorite_merchant_id)
  end

  private

  def customer_params
    params.permit(:id,
                  :first_name,
                  :last_name,
                  :created_at,
                  :updated_at,
                  :created_at)
  end
end
