class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.float :latitude
      t.float :longitude
      t.string :shop
      t.text :address
      t.timestamps
    end
  end
end
