class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @profile = Profile.find_by(user_id: current_user.id)
  end
end