class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update]

  def index
    @profile = Profile.find_by(user_id: current_user.id)
    @products = Product.where(profile: @profile)
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(params.require(:profile).permit(:name, :nick_name, :date_of_birth, :department, :role, :cpf))
    @profile.user_id = current_user.id
    @profile.company_id = current_user.company_id
    if @profile.save
      redirect_to profiles_path, notice: 'Cadastro efetuado com sucesso'
    else
      render :new
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update(params.require(:profile).permit(:name, :nick_name, :date_of_birth, :department, :role, :cpf))
    if @profile.save
      redirect_to profiles_path, notice: 'Dados alterados com sucesso'
    else
      render :edit
    end
  end
end 