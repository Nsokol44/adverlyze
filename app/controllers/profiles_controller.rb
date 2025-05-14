class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      @user.update(business_verified: false) if @user.role == "business"
      redirect_to root_path, notice: "Profile updated!"
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:role, :business_verification_document)
  end
end
