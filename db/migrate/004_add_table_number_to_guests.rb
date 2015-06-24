class AddTableNumberToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :table_number, :integer
  end
end
