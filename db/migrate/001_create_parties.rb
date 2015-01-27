class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|

      t.string  :code,   :unique => true
      t.string  :email

    end
  end
end
