class ProfilesController < ApplicationController
  before_action :authenticate_user!  # Asegurar que el usuario esté autenticado para las acciones excepto show
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def index
    @profiles = Profile.all
  end

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profiles.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @profile = @user.profiles.build
  end


  def create
    @user = User.find(params[:user_id])
    @profile = @user.profiles.build(profile_params)
    if @profile.save
      redirect_to user_profile_path(@user, @profile), notice: 'Perfil creado exitosamente.'
    else
      render :new, alert: 'Error al crear el perfil.'
    end
  end

  # Editar un perfil existente
  def edit
  end

  # Actualizar un perfil
  def update
    @profile = Profile.find(params[:id])
    @profile.update(profile_params)
    redirect_to profile_path(@profile)
  end

  # Eliminar un perfil
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    redirect_to user_profiles_path(current_user), status: :see_other
  end

  private

  # Encontrar el perfil basado en el parámetro id
  def set_profile
    @profile = Profile.find_by(id: params[:id])
  end

  # Solo permitir los parámetros permitidos
  def profile_params
    params.require(:profile).permit(:username, :gluten, :dairy, :penaut, :seafood, :soy, :egg, :sesame, :sugar, :vegetarian, :vegan, :user_id)
  end




end
