class Merchant < ActiveRecord::Base
  # default_scope -> { order('id DESC') }

  has_many :invoices
  has_many :items

  def self.random
    self.all.order("RANDOM()").first
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
