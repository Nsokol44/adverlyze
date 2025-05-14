class ImpressionsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    @ad = Ad.find(params[:ad_id])
    @impression = @ad.impressions.new(user: current_user, impression_type: params[:impression_type])
    @impression.save
    head :ok
  end  

  def edit
  end

  def update
  end

  def destroy
  end
end
