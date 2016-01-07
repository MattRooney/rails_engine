class Customer < ActiveRecord::Base
  # default_scope -> { order('id DESC') }

  has_many :invoices
  has_many :transactions, through: :invoices

  def self.random
    self.all.order("RANDOM()").first
  end

  def self.favorite_merchant_id(id)
    invoice_ids = Customer.find(id).transactions.where(result: "success").pluck(:invoice_id)
    merchant_ids = Invoice.find(invoice_ids).map { |invoice| invoice.merchant_id }
    freq = merchant_ids.inject(Hash.new(0)) { |hash,value| hash[value] += 1; hash }
    fav_merchant_id = merchant_ids.max_by{ |value| freq[value] }
    Merchant.find(fav_merchant_id)
  end
end
