class Merchant < ActiveRecord::Base
  # default_scope -> { order('id DESC') }

  has_many :invoices
  has_many :items

  def self.random
    self.all.order("RANDOM()").first
  end

end
