class CreateClothes < ActiveRecord::Migration[6.1]
  def change
    create_table :clothes do |t|
      t.references :brand_name, null: false, foreign_key: true
      t.integer :category, default: 0, null: false
      t.string :image, null: false
      t.integer :gender, null: false, default: 0

      t.timestamps
    end
  end
end
