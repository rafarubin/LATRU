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

    # Redirigir a la vista de historical/show
    redirect_to user_profile_product_historical_path(@user, @profile, @product, @historical), notice: "#{@historical.results}"
  end



  private

  def product_params
    params.require(:product).permit(:barcode, photos: [])
  end


  # def product_params
    # params.require(:product).permit(:name, :brand, :quantity, :portiion_nbr, :portion_qty, :gluten, :dairy, :penaut, :seafood, :soy, :egg, :sesame, :sugar, :vegetarian, :vegan, :calories, :fat, :fat_trans, :carb, :protein, :sugarqty, :photo)
  # end
end
