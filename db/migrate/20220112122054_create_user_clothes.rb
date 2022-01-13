class CreateUserClothes < ActiveRecord::Migration[6.1]
  def change
    create_table :user_clothes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :clothe, null: false, foreign_key: true
      t.integer :relation, null: false, default: 0
      t.integer :state, null: false, default: 0
      t.boolean :selected, null: false, default: 0

      t.timestamps
    end
  end
end
