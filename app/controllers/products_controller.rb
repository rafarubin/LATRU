class ProductsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    return unless @product.save
    return unless @product.set_product_attributes

    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])
    @historical = Historical.new(product_id: @product.id, profile_id: @profile.id)
    @historical.save
    @historical.calculate_result

    redirect_to user_profile_historical_path(@user, @profile, @historical)
  end


  private

  def product_params
    params.require(:product).permit(:barcode, photos: [])
  end

end
