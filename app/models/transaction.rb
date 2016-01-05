class Transaction < ActiveRecord::Base
  belongs_to :invoice

  def self.random
    self.all.order("RANDOM()").first
  end

end
