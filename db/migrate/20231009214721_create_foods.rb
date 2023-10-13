class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name, null: false, limit: 50
      t.string :measurement_unit, null: false, limit: 15
      t.float :price, null: false, precision: 10, scale: 2
      t.integer :quantity, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
