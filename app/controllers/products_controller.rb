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
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])
    if params[:product][:photos].present? && params[:product][:photos].count == 3
      if @product.save
        return unless @product.set_product_attributes

        @historical = Historical.new(product_id: @product.id, profile_id: @profile.id)
        @historical.save
        @historical.calculate_result
        redirect_to user_profile_historical_path(@user, @profile, @historical)
      else
        render :new, status: :unprocessable_entity, notice: "Debes tomar o adjuntar 2 fotos del producto"
      end
    else
      render :new, status: :unprocessable_entity, notice: "Debes tomar o adjuntar 2 fotos del producto"
    end
  end

  private

  def product_params
    params.require(:product).permit(:barcode, photos: [])
  end

end
