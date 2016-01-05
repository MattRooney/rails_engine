class Customer < ActiveRecord::Base
  has_many :invoices

  private

  def self.random
    self.all.order("RANDOM()").first
  end

end
