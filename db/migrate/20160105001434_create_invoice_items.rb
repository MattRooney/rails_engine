class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.references :invoice, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
      t.integer :quantity
      t.integer :unit_price
      t.string :created_at
      t.string :updated_at

      t.timestamps null: false
    end
  end
end
