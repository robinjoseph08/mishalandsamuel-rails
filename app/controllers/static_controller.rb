class StaticController < ApplicationController

  def index
    redirect_to "http://mishalandsamuel.com" + request.path if request.host == "www.mishalandsamuel.com"
  end

end
