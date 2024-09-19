class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(current_user)
    user_profiles_path(current_user)
  end

  def home
    @user = current_user
  end
end
