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

  # def create
  #   @product = Product.new(product_params)
  #   @user = User.find(params[:user_id])
  #   @profile = Profile.find(params[:profile_id])
  #   if params[:product][:photos].present? && params[:product][:photos].count == 2
  #     if @product.save

  #       render partial: 'form2'

  #       else
  #         render :new, status: :unprocessable_entity, notice: "Debes tomar o adjuntar 2 fotos del producto"
  #       end
  #     else
  #       render :new, status: :unprocessable_entity, notice: "Debes tomar o adjuntar 2 fotos del producto"
  #   end
  # end

  def create
    @product = Product.new(product_params)
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])
    if params[:product][:photos].present? && params[:product][:photos].count == 2
      if @product.save

        render :edit

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
      # new_photos = @product.photos
      # new_photos << params[:product][:photos]
      new_photos = params[:product][:photos].map do |photo|
        Cloudinary::Uploader.upload(photo)['secure_url']
      end
      @product.photos += new_photos
    else
      render :edit, status: :unprocessable_entity, notice: "Debes tomar o adjuntar 1 foto trasera del producto"
    end
      # if @product.update(product_params)
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


  # def create_second_photo
  #   @product = Product.find(params[:id])
  #   @user = User.find(params[:user_id])
  #   @profile = Profile.find(params[:profile_id])
  #   if params[:product][:photos].present? && params[:product][:photos].count == 3
  #     return unless @product.set_product_attributes

  #     @historical = Historical.new(product_id: @product.id, profile_id: @profile.id)
  #     @historical.save
  #     @historical.calculate_result
  #     redirect_to user_profile_historical_path(@user, @profile, @historical)
  #   else
  #     render partial: "form2", status: :unprocessable_entity, notice: "Debes tomar una foto del producto"
  #   end

  # end

  private

  def product_params
    params.require(:product).permit(:barcode, photos: [])
  end

end
