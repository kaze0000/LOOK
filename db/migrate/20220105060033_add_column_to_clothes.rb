class AddColumnToClothes < ActiveRecord::Migration[6.1]
  def change
    add_column :clothes, :admin_clothe, :boolean, default: false, null: false
  end
end
