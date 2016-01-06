class Api::V1::MerchantsController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(merchant_params)
  end

  def find
    respond_with Merchant.find_by(merchant_params)
  end

  def find_all
    respond_with Merchant.where(merchant_params)
  end

  def random
    respond_with Merchant.random
  end

  def items
    respond_with Merchant.find(params[:id]).items
  end

  def invoices
    respond_with Merchant.find(params[:id]).invoices
  end

  def revenue
    invoice_ids = Merchant.find(params[:id]).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    revenue = InvoiceItem.where(invoice_id: paid_invoice_ids).sum("unit_price * quantity")
    respond_with({"revenue" => revenue})
  end

  def favorite_customer
    invoice_ids = Merchant.find(params[:id]).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    customer_ids = Invoice.find(paid_invoice_ids).map { |invoice| invoice.customer_id }
    freq = customer_ids.inject(Hash.new(0)) { |hash,value| hash[value] += 1; hash }
    favorite_customer_id = customer_ids.max_by{ |value| freq[value] }
    respond_with Customer.find(favorite_customer_id)
  end

  def customers_with_pending_invoices
    invoice_ids = Merchant.find(params[:id]).invoices.pluck(:id)
    pending_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "failed").pluck(:invoice_id)
    customer_ids = Invoice.find(pending_invoice_ids).map { |invoice| invoice.customer_id }
    respond_with Customer.find(customer_ids)
  end

  

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end

end
