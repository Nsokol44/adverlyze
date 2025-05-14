class ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    @ad = Ad.find(params[:ad_id])
    @review = @ad.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      head :ok
    else
      head :unprocessable_entity
    end
  end
  
  private
  
  def review_params
    params.permit(:rating, :comment)
  end
  

  def edit
  end

  def update
  end

  def destroy
  end
end

