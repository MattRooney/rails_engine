class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :merchant, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.integer :unit_price
      t.string :created_at
      t.string :updated_at

      t.timestamps null: false
    end
  end
end
