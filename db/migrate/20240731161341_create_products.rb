class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title
      t.float :price
      t.integer :stock
      t.string :image_urls
      t.string :description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
