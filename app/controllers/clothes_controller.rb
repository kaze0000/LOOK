class ClothesController < ApplicationController
  before_action :set_q, only: [:search]
  skip_before_action :require_login

  def index
    @user_clothes = UserClothe.includes(:clothe, clothe: [:brand_name]).where(state: 0, relation: 0).order(created_at: :desc).page(params[:page])
  end

  def set
    set_clothe = UserClothe.new(user_id: current_user.id, clothe_id: params[:id], relation: 1 )
    if set_clothe.save
      redirect_to myclosets_path
    else
      render :index
    end
  end

  def search
    @results = @q.result.includes(:clothe, clothe: [:brand_name]).where(state: 0, relation: 0)
  end

  private
  
  def set_q
    @q = UserClothe.ransack(params[:q])
  end

end
