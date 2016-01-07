class Invoice < ActiveRecord::Base
  # default_scope -> { order('id DESC') }

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer
  belongs_to :merchant


  def self.random
    self.all.order("RANDOM()").first
  end

  def self.successfull
    joins(:transactions).where("result = 'success'")
  end

end
