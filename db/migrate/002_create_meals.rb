class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|

      t.string :name

    end

    m      = Meal.new
    m.name = "Chicken"
    m.save!

    m      = Meal.new
    m.name = "Fish"
    m.save!

    m      = Meal.new
    m.name = "Vegetarian"
    m.save!
  end
end
