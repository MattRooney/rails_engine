class Invoice < ActiveRecord::Base
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer
  belongs_to :merchant

  def self.random
    self.all.order("RANDOM()").first
  end

  default_scope -> { order('id DESC') }
end
