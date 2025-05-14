class AdsController < ApplicationController
  def index
    @ads = Ad.all
    respond_to do |format|
      format.html # renders index.html.erb by default
      format.json { render json: @ads }
    end
  end

  def show
    @ad = Ad.find(params[:id])
    # Show ad details, images, reviews, etc.
  end

  def new
    @ad = Ad.new
  end

  def create
    authorize Ad
  business = current_user.businesses.first
  unless business
    redirect_to new_business_path, alert: "You must create a business before creating an ad."
    return
  end
  @ad = business.ads.build(ad_params)
  if @ad.save
    redirect_to @ad
  else
    render :new
  end
  end

  def edit
    @ad = Ad.find(params[:id])
  end

  def update
    @ad = Ad.find(params[:id])
    if @ad.update(ad_params)
      redirect_to @ad
    else
      render :edit
    end
  end

  def destroy
    @ad = Ad.find(params[:id])
    @ad.destroy
    redirect_to ads_path
  end

  private

  def ad_params
    params.require(:ad).permit(:title, :description, :latitude, :longitude, :radius, :category, :images)
  end

  before_action :require_verified_business, only: [:new, :create]

  private

  def require_verified_business
    unless current_user&.verified_business?
      redirect_to root_path, alert: "Only verified businesses can create ads."
    end
  end
end
