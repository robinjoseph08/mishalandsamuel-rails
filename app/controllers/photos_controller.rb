class PhotosController < ApplicationController

  before_filter :find_photo, :only => [ :show ]

  def index
    if !params[:ids].nil?
      p = Photo.find params[:ids]
    else
      p = Photo.all
    end
    render :json => p
  end

  def show
    render :json => @photo
  end

  def update

  end

  private

  def find_photo
    @photo = Photo.find params[:id]
    if @photo.nil?
      puts "FIND PHOTO FAILED: #{params[:id]}"
      return render :json => false, :status => :not_found
    end
  end

end
