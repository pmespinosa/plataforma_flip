class HomeController < ApplicationController
  def home
  end

  def index
  end

  def prueba

  	@username = params['lis_person_sourcedid']
  	render :home

  end
end
