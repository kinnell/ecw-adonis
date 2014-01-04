class UsersController < ApplicationController

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

	private

  	def user_params
   	params.require(:user).permit(:name, :email, :location, :visible, :paid, :admin, :team_id)
  	end

end