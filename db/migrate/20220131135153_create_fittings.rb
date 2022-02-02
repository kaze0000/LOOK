class CreateFittings < ActiveRecord::Migration[6.1]
  def change
    create_table :fittings do |t|
      t.string :image, null: false
      t.timestamps
    end
  end
end
