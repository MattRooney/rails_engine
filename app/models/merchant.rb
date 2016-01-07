class Merchant < ActiveRecord::Base
  # default_scope -> { order('id DESC') }

  has_many :invoices
  has_many :items

  def self.random
    self.all.order("RANDOM()").first
  end

  def self.revenue(id)
    invoice_ids = Merchant.find(id).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    revenue = InvoiceItem.where(invoice_id: paid_invoice_ids).sum("unit_price * quantity")
    { "revenue" => revenue }
  end

  def self.favorite_customer(id)
    invoice_ids = Merchant.find(id).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    customer_ids = Invoice.find(paid_invoice_ids).map { |invoice| invoice.customer_id }
    freq = customer_ids.inject(Hash.new(0)) { |hash,value| hash[value] += 1; hash }
    favorite_customer_id = customer_ids.max_by{ |value| freq[value] }
    Customer.find(favorite_customer_id)
  end

  def self.customers_with_pending_invoices(id)
    invoice_ids = Merchant.find(id).invoices.pluck(:id)
    pending_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "failed").pluck(:invoice_id)
    customer_ids = Invoice.find(pending_invoice_ids).map { |invoice| invoice.customer_id }
    Customer.find(customer_ids)
  end

  def self.most_items(quantity)
    all.sort_by(&:calc_items).reverse[0...quantity.to_i]
  end

  def calc_items
    invoices.successfull.joins(:invoice_items).sum(:quantity)
  end

  def self.most_revenue(quantity)
    all.sort_by(&:calc_revenue).reverse[0...quantity.to_i]
  end

  def calc_revenue
   invoices.successfull.joins(:invoice_items).sum("unit_price * quantity")
  end

end
