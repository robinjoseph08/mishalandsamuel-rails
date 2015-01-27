class MealsController < ApplicationController

  before_filter :find_meal, :only => [ :show ]

  def index
    if !params[:ids].nil?
      m = Meal.find params[:ids]
    else
      m = Meal.all
    end
    render :json => m
  end

  def show
    render :json => @meal
  end

  def update

  end

  private

  def find_meal
    @meal = Meal.find params[:id]
    if @meal.nil?
      puts "FIND MEAL FAILED: #{params[:id]}"
      return render :json => false, :status => :not_found
    end
  end

end
