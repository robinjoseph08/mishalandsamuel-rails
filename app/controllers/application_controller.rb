class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  def print_line
    puts "="*80
  end

end
