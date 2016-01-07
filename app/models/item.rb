class Item < ActiveRecord::Base
  # default_scope -> { order('id DESC') }

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  before_save :format_dollar


  def format_dollar
    self.unit_price = unit_price/100.00
  end

  def self.random
    self.all.order("RANDOM()").first
  end

  def self.most_revenue(quantity)
    all.sort_by(&:calc_revenue).reverse[0...quantity.to_i]
  end

  def calc_revenue
   invoice_items.joins(:invoice).sum("unit_price * quantity")
  end

  def self.most_items(quantity)
    all.sort_by(&:calc_items).reverse[0...quantity.to_i]
  end

  def calc_items
    invoice_items.joins(:invoice).sum(:quantity)
  end

end
