class WeighinsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_weighin, only: [:show, :edit, :update, :destroy]


  def index
    @weighins = Weighin.all
  end

  def show
  end

  def new
    @weighin = current_user.weighins.build
  end

  def edit
  end

  def create
    @weighin = current_user.weighins.build(weighin_params)
    if @weighin.save
      redirect_to weighins_url, notice: 'Weigh-in was successfully added.'
    else
      render action: 'new'
    end
  end

  def update
    if @weighin.update(weighin_params)
      redirect_to weighins_url, notice: 'Weigh-in was successfully editted.'
    else
      render action: 'edit'
    end  
  end

  def destroy
    @weighin.destroy
    redirect_to weighins_url, notice: 'Weigh-in was successfully deleted.'
  end

  def verify
    @weighin = Weighin.find(params[:id])
    if @weighin.update_attributes(:verified => true)
      redirect_to weighins_url, notice: 'Weigh-in was verified.'
    end 
  end

  def unverify
    @weighin = Weighin.find(params[:id])
    if @weighin.update_attributes(:verified => false)
      redirect_to weighins_url, notice: 'Weigh-in was unverified.'
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
