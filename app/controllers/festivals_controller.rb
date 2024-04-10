class FestivalsController < ApplicationController
  before_action :set_festival, only: [:show, :edit, :update, :destroy]

  # GET /festivals
  def index
    @festivals = Festival.all
  end

  # GET /festivals/1
  def show
  end

  # GET /festivals/new
  def new
    @festival = Festival.new
  end

  # GET /festivals/1/edit
  def edit
  end

  # POST /festivals
  def create
    @festival = Festival.new(festival_params)
    if @festival.save
      redirect_to @festival, notice: 'Festival was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /festivals/1
  def update
    if @festival.update(festival_params)
      redirect_to @festival, notice: 'Festival was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /festivals/1
  def destroy
    @festival.destroy
    redirect_to festivals_url, notice: 'Festival was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_festival
      @festival = Festival.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def festival_params
      params.require(:festival).permit(:name, :location, :start_date, :end_date)
    end
end
