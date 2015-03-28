class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|

      t.belongs_to :meal
      t.belongs_to :party

      t.string  :name
      t.integer :response, :default => 0
      t.string  :email

    end
  end
end
