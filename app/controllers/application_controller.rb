class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  def home
    @user = current_user63
  end
end
