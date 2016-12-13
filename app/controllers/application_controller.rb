class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :reset_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :signin_edx

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password,
      :password_confirmation, :remember_me, :first_name, :last_name)}
    devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(:email, :password,
      :password_confirmation, :remember_me, :first_name, :last_name)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password,
      :password_confirmation, :remember_me, :first_name, :last_name)}
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      users_path
    else
      super
    end
  end

  def signin_edx
    if params[:lis_person_contact_email_primary]
      user = User.find_by email: params[:lis_person_contact_email_primary]
      sign_in user if user
    end
  end
end
