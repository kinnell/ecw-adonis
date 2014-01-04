class WeighinsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_weighin, only: [:show, :edit, :update, :destroy]


  def index
    @weighins = Weighin.all
  end

  def leaderboard
    @weighins = Weighin.all
  end

  def myProgress
    @weighins = current_user.weighins
  end

  def show

  end

  def directory
  end


  def new
    @weighin = current_user.weighins.build
  end

  def edit
  end

  def create
    @weighin = current_user.weighins.build(weighin_params)
    if @weighin.save
      redirect_to :back, notice: 'Weigh-in was successfully added.'
    else
      render action: 'new'
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

  def promote
    @user = User.find(params[:id])
    if @user.update_attributes(:admin => true)
      redirect_to :back, notice: 'User was promoted to Admin.'
    end 
  end

  def demote
    @user = User.find(params[:id])
    if @user.update_attributes(:admin => false)
      redirect_to :back, notice: 'Admin was demoted to User.'
    end
  end

  def destroyUser
    @user = User.find(params[:id])

    if @user.destroy
        redirect_to :back, notice: "User was deleted."
    end
  end

  def hasPaid
    @user = User.find(params[:id])
    if @user.update_attributes(:paid => true)
      redirect_to :back, notice: 'User has been set to have paid.'
    end 
  end

  def hasNotPaid
    @user = User.find(params[:id])
    if @user.update_attributes(:paid => false)
      redirect_to :back, notice: 'User has been set to have not paid.'
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weighin
      @weighin = Weighin.find(params[:id])
    end

    def correct_user
      @weighin = current_user.weighin.find_by(id: params[:id])
      redirect_to weighin_path, notice: "Not authorized to edit this weighin" if @pin.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weighin_params
      params.require(:weighin).permit(:weight)
    end
end
