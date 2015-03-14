class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|

      t.string :name

    end

    m      = Meal.new
    m.name = "Beef"
    m.save!

    m      = Meal.new
    m.name = "Chicken"
    m.save!

    m      = Meal.new
    m.name = "Fish"
    m.save!

    m      = Meal.new
    m.name = "Vegetarian"
    m.save!

    m      = Meal.new
    m.name = "Kid's Meal, Ages 3-12"
    m.save!

    m      = Meal.new
    m.name = "Child Under 2"
    m.save!
  end
end
