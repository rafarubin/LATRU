class HistoricalsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])
    @historicals = Historical.where(profile_id: @profile.id)
    if params[:query].present?
      @historicals = Historical.search_product(params[:query])
    end
  end

  def show
    @historical = Historical.find(params[:id])
    @product = @historical.product
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])

    @attributes_to_display = []

    attribute_names = {
      "gluten" => "gluten",
      "peanut" => "maní",
      "seafood" => "comida marina",
      "soy" => "soja",
      "egg" => "huevo",
      "sesame" => "sésamo",
      "sugar" => "azúcar",
      "vegetarian" => "vegetariano",
      "vegan" => "vegano",
      "dairy" => "lácteos"
    }

    attributes = %w[gluten peanut seafood soy egg sesame sugar vegetarian vegan dairy]

    attributes.each do |attribute|
      product_value = @product.send(attribute)
      profile_value = @profile.send(attribute)

      if product_value == false && profile_value == true

        @attributes_to_display << attribute_names[attribute]
      end
    end

    # recomendaciones
    @recom = @historical.recom_answer(@attributes_to_display)
  end
end
