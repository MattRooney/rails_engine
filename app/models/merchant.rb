class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def self.random
    self.all.order("RANDOM()").first
  end


end
