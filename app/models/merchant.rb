class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  default_scope -> { order('id DESC') }

  def self.random
    self.all.order("RANDOM()").first
  end

end
