class HistoricalsController < ApplicationController
  def show
    @historical = Historical.find(params[:id])
    @product = @historical.product
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])

    # Lista de atributos relevantes
    @attributes_to_display = []
    attributes = %w[gluten peanut seafood soy egg sesame sugar vegetarian vegan dairy]

    attributes.each do |attribute|
      product_value = @product.send(attribute)
      profile_value = @profile.send(attribute)

      # Condición: verdadero en producto y falso en perfil
      if product_value == true && profile_value == false
        @attributes_to_display << attribute
      end
    end
  end
end
