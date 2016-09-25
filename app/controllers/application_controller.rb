class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :update_points

  def update_points
    
  end
end
