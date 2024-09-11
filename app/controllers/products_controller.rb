class ProductsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    return unless @product.save
    return unless @product.set_product_attributes

    redirect_to product_path(@product)
  end


  private

  def product_params
    params.require(:product).permit(photos: [])
  end


  # def product_params
    # params.require(:product).permit(:name, :brand, :quantity, :portiion_nbr, :portion_qty, :gluten, :dairy, :penaut, :seafood, :soy, :egg, :sesame, :sugar, :vegetarian, :vegan, :calories, :fat, :fat_trans, :carb, :protein, :sugarqty, :photo)
  # end
end
