class Api::V1::InvoicesController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find_by(invoice_params)
  end

  def find
    respond_with Invoice.find_by(invoice_params)
  end

  def find_all
    respond_with Invoice.where(invoice_params)
  end

  def random
    respond_with Invoice.random
  end

  def transactions
    respond_with Invoice.find_by(invoice_params).transactions
  end

  def invoice_items
    respond_with Invoice.find_by(invoice_params).invoice_items
  end

  def items
    respond_with Invoice.find_by(invoice_params).items
  end

  def customer
    respond_with Invoice.find_by(invoice_params).customer
  end

  def merchant
    respond_with Invoice.find_by(invoice_params).merchant
  end

  private

  def invoice_params
    params.permit(:id,
                  :customer_id,
                  :merchant_id,
                  :status,
                  :created_at,
                  :updated_at)
  end
end
