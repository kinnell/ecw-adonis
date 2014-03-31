class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:leaderboard]
  before_action :check_if_admin, only: [:treasury, :dashboard, :leaderboard]

  def home
  end

  def leaderboard
    @users = User.visible.paid.withVerifiedWeighins
    @teams = Team.withUsers
  end

  def adminLeaderboard
    @users = User.paid.withVerifiedWeighins
    @teams = Team.withUsers
  end

  def finalLeaderboard
    @users = User.paid.withVerifiedWeighins
    @teams = Team.withUsers
  end

  def testLeaderboard
    @users = User.all
  end

  def treasury
  end

  def dashboard
  end

  def changelog
  end

end
