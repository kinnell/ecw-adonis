class TeamsController < ApplicationController
  before_filter :check_if_admin, only: [:new, :edit, :index]
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all
  end

  def myTeam
  end

  def show
    @team = Team.find(params[:id])
  end

  def edit
  end



  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to :back, notice: 'Team was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
      if @team.update(team_params)
        redirect_to teams_path, notice: 'Team was successfully updated.'
      else
        render action: 'edit'
      end
  end

  def destroy
    @team.destroy
      redirect_to teams_path, notice: 'Team was successfully deleted.'
  end

  def join
    @team = Team.find(params[:id])
    if current_user.update_attributes(:team_id => @team.id)
      redirect_to :back, notice: 'Joined team'
    end 
  end

  def leave
    @team = Team.find(params[:id])
    if current_user.update_attributes(:team_id => nil)
      redirect_to :back, notice: 'Left team'
    end 
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end
end
