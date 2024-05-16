class FestivalLovePodsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @festival = Festival.find(params[:festival_id])
    @love_pod = LovePod.find(params[:love_pod_id])
    @festival_love_pod = FestivalLovePod.find(params[:love_pod_id])
  end

  private

  def festival_love_pod_params
    params.require(:festival_love_pod).permit(:love_pod_id, :festival_id)
  end
end
