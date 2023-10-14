class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false, limit: 50
      t.decimal :preparation_time, null: false, precision: 4, scale: 2
      t.decimal :cooking_time, null: false, precision: 4, scale: 2
      t.text :description, null: false
      t.boolean :public, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
