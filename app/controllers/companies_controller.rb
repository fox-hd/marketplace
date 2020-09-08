class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
      @company = Company.find_by(id: current_user.company_id)
      @profiles = @company.profiles
  end

  def show
    @profile = Profile.find(params[:id])
  end
end