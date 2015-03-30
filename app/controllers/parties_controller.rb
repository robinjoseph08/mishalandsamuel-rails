class PartiesController < ApplicationController

  before_filter :find_party, :only => [ :show, :update ]

  def index
    if !params[:ids].nil?
      p = Party.find params[:ids]
    elsif !params[:code].nil?
      p = Party.where :code => params[:code].upcase.strip
    else
      p = Party.all
    end
    render :json => p
  end

  def show
    render :json => @party
  end

  def update
    print_line
    puts "PARTY UPDATE: #{params[:id]}"

    errors = []
    @party.assign_attributes party_params
    unless @party.valid?
      errors = errors.concat @party.errors.full_messages
    end
    unless errors.empty?
      puts "PARTY UPDATE FAILED: #{errors}"
      return render :json => { :errors => errors }.to_json, :status => :not_acceptable
    end
    puts "PARTY UPDATE SUCCESS: #{@party.id}"
    @party.save
    render :json => @party
    print_line
  end

  private

  def find_party
    @party = Party.find params[:id]
    if @party.nil?
      puts "FIND PARTY FAILED: #{params[:id]}"
      return render :json => false, :status => :not_found
    end
  end

  def party_params
    ret = params.require(:party).permit()
    ret.each do |attr|
      ret[attr[0]] = attr[1].strip.chomp rescue attr[1]
    end
    ret
  end

end
