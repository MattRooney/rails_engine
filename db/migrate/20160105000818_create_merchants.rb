class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :created_at
      t.string :updated_at

      t.timestamps null: false
    end
  end
end
