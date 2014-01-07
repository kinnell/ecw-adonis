class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin



	def index
	 @users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
    	if @user.update_attributes(user_params)
  			redirect_to :back, notice: 'User was updated.'
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

  	def user_params
   	params.require(:user).permit(:name, :email, :location, :visible, :paid, :admin, :team_id)
  	end

end