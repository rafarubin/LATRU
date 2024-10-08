require "open-uri"

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
    if params[:product][:photos].present? && params[:product][:photos].count == 2
      if @product.save

        redirect_to edit_user_profile_product_path(@user, @profile, @product)
        else
          render :new, status: :unprocessable_entity, notice: "Debes tomar o adjuntar 1 foto delantera del producto"
        end
      else
        render :new, status: :unprocessable_entity, notice: "Debes tomar o adjuntar 1 foto delantera del producto"
    end
  end

  def edit
    @product = Product.find(params[:id])
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])
  end

  def update
    @product = Product.find(params[:id])
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])

    if params[:product][:photos].present?
      uploaded_photo = Cloudinary::Uploader.upload(params[:product][:photos])['secure_url']
      @product.photos.attach(io: URI.open(uploaded_photo), filename: params[:product][:photos].original_filename)
    else
      render :edit, status: :unprocessable_entity, notice: "Debes tomar o adjuntar 1 foto trasera del producto"
    end
    if @product.save
      return unless @product.set_product_attributes

      @historical = Historical.new(product_id: @product.id, profile_id: @profile.id)
      @historical.save
      @historical.calculate_result
      redirect_to user_profile_historical_path(@user, @profile, @historical)
    else
      render :edit, status: :unprocessable_entity, notice: "Debes tomar o adjuntar 1 foto trasera del producto"
    end
  end

  private

  def product_params
    params.require(:product).permit(:barcode, photos: [])
  end

end
