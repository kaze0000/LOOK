class FittingsController < ApplicationController
  def index
    @selected_bottoms = Clothe.joins(:user_clothes).bottoms.merge(UserClothe.selected(current_user))
    @selected_tops = Clothe.joins(:user_clothes).tops.merge(UserClothe.selected(current_user))
    @fitting = Fitting.new
  end

  def create
    @fitting = Fitting.new(image: params[:fitting][:image], user_id: current_user.id)
    if @fitting.save
      redirect_to fitting_myclosets_path
    else
      redirect_to fitting_myclosets_path
    end
    @tweeted_fitting_image = Fitting.where(user_id: current_user.id).order(updated_at: :desc).limit(1)
  end
  
end
