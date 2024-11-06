class CreateCartItems < ActiveRecord::Migration[7.2]
  def change
    create_table :cart_items do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
