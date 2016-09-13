class HomeController < ApplicationController
  before_action :set_breadcrumbs
  def home
    if user_signed_in?
      redirect_to users_path
    end
  end

  def index
  end

  private

  def set_breadcrumbs
    @breadcrumbs = []
  end

end
