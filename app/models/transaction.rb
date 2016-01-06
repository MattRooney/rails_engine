class Transaction < ActiveRecord::Base
  # default_scope -> { order('id DESC') }

  belongs_to :invoice

  def self.random
    self.all.order("RANDOM()").first
  end

end
