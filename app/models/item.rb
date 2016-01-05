class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  before_save :format_dollar

  private

  def format_dollar
    self.unit_price = unit_price/100.00
  end

  def self.random
    self.all.order("RANDOM()").first
  end


end
