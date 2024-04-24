class LovePodsController < ApplicationController
  before_action :set_love_pod, only: [:show, :edit, :update, :destroy]

  def index
    @love_pods = LovePod.all
  end

  def new
    @love_pod = LovePod.new
  end

  def create
    @love_pod = LovePod.new(love_pod_params)
    if @love_pod.save
      redirect_to @love_pod, notice: 'Love pod was successfully created.'
    else
      render :new
    end
  end

  def show
    @love_pod = LovePod.find(params[:id])
  end

  def edit
  end

  def update
    if @love_pod.update(love_pod_params)
      redirect_to @love_pod, notice: 'Love pod was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @love_pod.destroy
    redirect_to love_pods_path, notice: 'Love pod was successfully destroyed.'
  end

  private

    def set_love_pod
      @love_pod = LovePod.find(params[:id])
    end

    def love_pod_params
      params.require(:love_pod).permit(:name, :description, :capacity)
    end
end