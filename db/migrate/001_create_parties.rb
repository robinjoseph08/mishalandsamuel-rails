class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|

      t.string  :code,  :unique => true
      t.integer :label
      t.string  :address1
      t.string  :address2
      t.string  :city
      t.string  :state
      t.string  :zip
      t.string  :country

    end
  end
end
