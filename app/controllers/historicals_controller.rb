class HistoricalsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])
    @historicals = Historical.where(profile_id: @profile.id)
  end

  def show
    @historical = Historical.find(params[:id])
    @product = @historical.product
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])
  end
end
