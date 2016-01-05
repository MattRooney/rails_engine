class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :customer, index: true, foreign_key: true
      t.references :merchant, index: true, foreign_key: true
      t.string :status
      t.string :created_at
      t.string :updated_at

      t.timestamps null: false
    end
  end
end
