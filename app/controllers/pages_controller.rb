class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:leaderboard]
  before_action :check_if_admin, only: [:treasury, :dashboard]

  def home
  end

  def leaderboard
    @users = User.all
  end

  def treasury
  end

  def dashboard
  end

end
