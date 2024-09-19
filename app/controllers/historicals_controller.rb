class HistoricalsController < ApplicationController
  before_action :set_user_and_profile, only: [:index, :show, :destroy]

  def index
    @historicals = Historical.where(profile_id: @profile.id)
  end

  def show
    @historical = Historical.find(params[:id])
    @product = @historical.product
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

    @recom = @historical.recom_answer(@attributes_to_display)
  end

  def destroy
    @historical = Historical.find(params[:id])
    if @historical.destroy
      flash[:notice] = "Historial eliminado correctamente."
    else
      flash[:alert] = "Error al eliminar el historial."
    end
    redirect_to user_profile_historicals_path(@user, @profile)
  end

  private

  def set_user_and_profile
    @user = User.find(params[:user_id])
    @profile = Profile.find(params[:profile_id])
  end
end
