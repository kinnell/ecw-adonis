class WeighinsController < ApplicationController
  before_action :set_weighin, only: [:show, :edit, :update, :destroy]

  def index
    @weighins = Weighin.all
  end

  def show
  end

  def new
    @weighin = Weighin.new
  end

  def edit
  end

  def create
    @weighin = Weighin.new(weighin_params)
    if @weighin.save
      redirect_to @weighin, notice: 'Weighin was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @weighin.update(weighin_params)
      format.html { redirect_to @weighin, notice: 'Weighin was successfully updated.' }
    else
      format.html { render action: 'edit' }
    end  
  end

  def destroy
    @weighin.destroy
    redirect_to weighins_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weighin
      @weighin = Weighin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weighin_params
      params.require(:weighin).permit(:weight)
    end
end
