class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def index
    @profiles = @user.profiles
  end

  def show
  end

  def new
    @profile = @user.profiles.new
  end

  def create
    @profile = @user.profiles.new(profile_params)

    if @profile.save
      redirect_to user_profiles_path(@user), notice: 'Perfil creado exitosamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to user_profiles_path(@user), notice: 'Perfil actualizado con éxito.'
    else
      render :edit
    end
  end

  def destroy
    @profile.destroy
    redirect_to user_profiles_path(@user), notice: 'Perfil eliminado correctamente.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_profile
    @profile = @user.profiles.find_by(id: params[:id])
    if @profile.nil?
      redirect_to user_profiles_path(@user), alert: "Perfil no encontrado"
    end
  end

  def profile_params
    params.require(:profile).permit(:username, :gluten, :dairy, :peanut, :seafood, :soy, :egg, :sesame, :sugar, :vegetarian, :vegan)
  end

  def assign_random_color
    self.color = COLORS.sample
  end
end
