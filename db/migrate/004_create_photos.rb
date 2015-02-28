class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|

      t.text  :data_url

    end
  end
end
