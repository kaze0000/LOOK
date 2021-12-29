class CreateClothes < ActiveRecord::Migration[6.1]
  def change
    create_table :clothes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :brand_name, null: false, foreign_key: true
      t.integer :type
      t.string :image
      t.integer :gender
      t.boolean :selected

      t.timestamps
    end
  end
end
