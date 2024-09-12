class BarcodesController < ApplicationController

  def new
    @barcode = Barcode.new
  end


  def create
    # Enviar una foto a CL
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

      redirect_to @barcode, notice: "Producto creado exitosamente y foto subida a Cloudinary #{img_url}"
    else
      render :new, alert: "Error al crear el producto."
    end

  end

  def show
    @barcode = Barcode.find(params[:id])
    url = 'https://res.cloudinary.com/dgsvzneh5/image/upload/v1/development/4jn9fkme8j6fs65s11rn7617pt81?_a=BACADKBn'
    @answer = @barcode.barcode_scan
    # http://127.0.0.1:3000/barcodes/15
    @search = @barcode.product_exists?
  end

  private
  def barcode_params
     # params.require(:barcode).permit(:name, :brand, :quantity, :portiion_nbr, :portion_qty, :gluten, :dairy, :penaut, :seafood, :soy, :egg, :sesame, :sugar, :vegetarian, :vegan, :calories, :fat, :fat_trans, :carb, :protein, :sugarqty, :photo)
    params.require(:barcode).permit(:photo)
  end
end
