class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:leaderboard]

  def home
  end

  def leaderboard
  end


end
