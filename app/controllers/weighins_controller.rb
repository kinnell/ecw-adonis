class WeighinsController < ApplicationController  
  before_action :authenticate_user!
  before_action :check_if_admin, only: [:edit, :update, :verify, :unverify]
  before_action :set_weighin, only: [:show, :edit, :update, :destroy]
  before_action :expireAllFragments

  def myProgress
    @weighins = current_user.weighins
  end

  def new
    @weighin = current_user.weighins.build
  end

  def edit
  end

  def create
    @weighin = Weighin.new(weighin_params)

    if @weighin.save
      redirect_to :back, notice: 'Weigh-in was successfully added.'
    else
      redirect_to :back, notice: 'Weigh-in weight was invalid'
    end
  end

  def update
    if @weighin.update(weighin_params)
      redirect_to :back, notice: 'Weigh-in was successfully editted.'
    else
      render action: 'edit'
    end  
  end

  def destroy
    @weighin.destroy
    redirect_to :back, notice: 'Weigh-in was successfully deleted.'
  end

  def verify
    @weighin = Weighin.find(params[:id])
    if @weighin.update_attributes(:verified => true)
      redirect_to :back, notice: 'Weigh-in was verified.'
    end 
  end

  def unverify
    @weighin = Weighin.find(params[:id])
    if @weighin.update_attributes(:verified => false)
      redirect_to :back, notice: 'Weigh-in was unverified.'
    end 
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weighin
      @weighin = Weighin.find(params[:id])
    end

    def expireAllFragments
      expire_fragment('users_leaderboard')
      expire_fragment('teams_leaderboard')
    end

    # def correct_user
    #  @weighin = current_user.weighin.find_by(id: params[:id])
    #  redirect_to weighin_path, notice: "Not authorized to edit this weighin" if @pin.nil?
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weighin_params
      params.require(:weighin).permit(:weight, :user_id, :verified)
    end
end
