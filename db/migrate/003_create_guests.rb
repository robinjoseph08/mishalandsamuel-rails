class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|

      t.belongs_to :meal
      t.belongs_to :party

      t.string  :name
      t.boolean :coming

    end
  end
end
