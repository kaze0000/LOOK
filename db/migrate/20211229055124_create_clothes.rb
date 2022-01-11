class CreateClothes < ActiveRecord::Migration[6.1]
  def change
    create_table :clothes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :brand_name, null: false, foreign_key: true
      t.integer :genre, null: false, default: 0
      t.string :image, null: false
      t.integer :gender, null: false, default: 0
      t.boolean :selected, null: false, default: false

      t.timestamps
    end
  end
end
