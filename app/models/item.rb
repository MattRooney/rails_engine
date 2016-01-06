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


end
