class Customer < ActiveRecord::Base
  # default_scope -> { order('id DESC') }

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.random
    self.all.order("RANDOM()").first
  end

  def favorite_merchant
    merchants.select("merchants.*, count(invoices.merchant_id) AS invoice_count")
             .joins(invoices: :transactions)
             .where(transactions: { result: "success" } )
             .group("merchants.id")
             .order('invoice_count DESC').first
  end
end
