class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :products
      t.integer :tax
      t.string :total

      t.timestamps
    end
  end
end
