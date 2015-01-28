class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|

      t.string  :code,  :unique => true
      t.integer :label
      t.string  :email

    end
  end
end
