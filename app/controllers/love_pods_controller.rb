class LovePodsController < ApplicationController
  before_action :set_festival
  before_action :set_love_pod, only: [:show, :edit, :update, :destroy]

  def new
    @love_pod = @festival.love_pods.build
  end

  def create
    @love_pod = @festival.love_pods.build(love_pod_params)
    if @love_pod.save
      redirect_to [@festival, @love_pod], notice: 'Love pod was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @love_pod.update(love_pod_params)
      redirect_to [@festival, @love_pod], notice: 'Love pod was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @love_pod.destroy
    redirect_to festival_love_pods_path(@festival), notice: 'Love pod was successfully destroyed.'
  end

  private

    def set_festival
      @festival = Festival.find(params[:festival_id])
    end

    def set_love_pod
      @love_pod = LovePod.find(params[:id])
    end

    def love_pod_params
      params.require(:love_pod).permit(:name, :description, :capacity)
    end
end
