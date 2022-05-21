class FittingsController < ApplicationController
  skip_before_action :require_login, only: %i[secret]

  def index
    @selected_bottoms = Clothe.joins(:user_clothes).bottoms.merge(UserClothe.selected(current_user))
    @selected_tops = Clothe.joins(:user_clothes).tops.merge(UserClothe.selected(current_user))
    @fitting = Fitting.new
  end

  def create
      redirect_to ("https://twitter.com/intent/tweet?text=服が試着できるサービス%20LOOK&url=https://www.look-closet.com/")
  end

  def secret
    @tweet_item = Fitting.find(params[:id])
  end

  private
  
  def fitting_params
    params.require(:fitting).permit(:user_id, :image)
  end
  
end
