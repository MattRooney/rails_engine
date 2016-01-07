class InvoiceItem < ActiveRecord::Base
  # default_scope -> { order('id DESC') }

  belongs_to :invoice
  belongs_to :item

  before_save :format_dollar


  def format_dollar
    self.unit_price = unit_price/100.00
  end

  def self.random
    self.all.order("RANDOM()").first
  end

end
