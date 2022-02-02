class AddColumnToFitting < ActiveRecord::Migration[6.1]
  def change
    add_reference :fittings, :user, null: false, foreign_key: true
  end
end
