class Transaction < ActiveRecord::Base
  # default_scope -> { order('id DESC') }

  belongs_to :invoice

  def self.random
    self.all.order("RANDOM()").first
  end

  def self.successfull
    joins(:transactions).where("result = 'success'")
  end

end
