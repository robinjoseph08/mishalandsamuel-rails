class GuestsController < ApplicationController

  before_filter :find_guest, :only => [ :show, :update ]

  def index
    if !params[:ids].nil?
      g = Guest.find params[:ids]
    else
      g = Guest.all
    end
    render :json => g
  end

  def show
    render :json => @guest
  end

  def update
    print_line
    puts "GUEST UPDATE: #{params[:id]}"

    errors = []
    @guest.assign_attributes guest_params
    unless @guest.valid?
      errors = errors.concat @guest.errors.full_messages
    end
    unless errors.empty?
      puts "GUEST UPDATE FAILED: #{errors}"
      return render :json => { :errors => errors }.to_json, :status => :not_acceptable
    end
    puts "GUEST UPDATE SUCCESS: #{@guest.id}"
    @guest.save
    render :json => @guest
    print_line
  end

  private

  def find_guest
    @guest = Guest.find params[:id]
    if @guest.nil?
      puts "FIND GUEST FAILED: #{params[:id]}"
      return render :json => false, :status => :not_found
    end
  end

  def guest_params
    ret = params.require(:guest).permit(:response, :under_2_years, :meal_id)
    ret.each do |attr|
      ret[attr[0]] = attr[1].strip.chomp rescue attr[1]
    end
    ret
  end

end
