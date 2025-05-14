class BusinessesController < ApplicationController
    # Add your actions here, for example:
    def new
      @business = Business.new
    end
  
    def create
      @business = current_user.businesses.build(business_params)
      if @business.save
        redirect_to @business
      else
        render :new
      end
    end
  
    private
  
    def business_params
      params.require(:business).permit(:name, :description) # add other permitted fields as needed
    end

    def show
        @business = Business.find(params[:id])
        # This will render app/views/businesses/show.html.erb by default
        unless @business
            redirect_to businesses_path, alert: "Business not found."
          end
    end

  end
  