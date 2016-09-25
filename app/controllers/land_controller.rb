class LandController < ApplicationController
  def land
    respond_to do |format|
      format.html {render 'index', :layout => 'landing'}
    end
  end

  def gold
    respond_to do |format|
    format.html {render 'gold', :layout => 'landing'}
    end
  end
end
