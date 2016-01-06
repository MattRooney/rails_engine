class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :invoice, index: true, foreign_key: true
      t.string :credit_card_number
      t.string :result
      t.string :created_at
      t.string :updated_at

      t.timestamps null: false
    end
  end
end
