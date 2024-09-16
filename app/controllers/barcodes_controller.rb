class BarcodesController < ApplicationController

  def new
    @barcode = Barcode.new
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])
  end


  def create
    # Enviar una foto a CL
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])
    @barcode = Barcode.new(barcode_params)
    if @barcode.save
      if @barcode.photo.attached?
        img_key = @barcode.photo.key
        # Usar el helper de Cloudinary para generar la URL de la imagen
        img_url = Cloudinary::Utils.cloudinary_url(img_key, version: "1/development")
      else
        render :new, status: :unprocessable_entity
      end

      @barcode.barcode_scan # metodo para OpenAI API Vision
      @barcode.barcode_num = @barcode.barcode_scan # alamceno en DB
      @barcode.save
      @search = @barcode.product_exists?
      # logica de match

      if @search
        # existe, llamo al product, profile
        @historical = Historical.new(product_id: @search, profile_id: @profile.id)
        @historical.save
        @historical.calculate_result
        redirect_to user_profile_historical_path(@user, @profile, @historical), notice: "#{@historical.results}"
      else
        # es nuevo, lo creo
        # envio de param1 con el valor del barcode escaneado
        redirect_to new_user_profile_product_path(@user, @profile, @barcode, param1: @barcode.barcode_num)
      end
    else
      render :new, alert: "Error al crear el producto."
    end

  end

  def show
    @barcode = Barcode.find(params[:id])
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])
    @answer = @barcode.barcode_scan
    @search = @barcode.product_exists?
  end

  private
  def barcode_params
     # params.require(:barcode).permit(:name, :brand, :quantity, :portiion_nbr, :portion_qty, :gluten, :dairy, :penaut, :seafood, :soy, :egg, :sesame, :sugar, :vegetarian, :vegan, :calories, :fat, :fat_trans, :carb, :protein, :sugarqty, :photo)
    params.require(:barcode).permit(:photo)
  end
end
