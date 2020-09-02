class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @profile = Profile.find_by(user_id: current_user.id)
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
      redirect_to @profile, notice: 'Cadastro efetuado com sucesso'
    else
      render :new
    end
  end
end 