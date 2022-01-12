class ClothesController < ApplicationController
  before_action :set_q, only: [:search]
  skip_before_action :require_login

  def index
    @clothes = Clothe.includes(:brand_name).joins(:user).where(user: {role: 0}).order(created_at: :desc).page(params[:page])
  end

  def set
    clothe = Clothe.find(params[:id])
    set_clothe = BrandName.new(name: clothe.brand_name.name, clothe_attributes: { genre: clothe.genre, user_id: current_user.id, image: clothe.image })
    if set_clothe.save
      redirect_to myclosets_path
    else
      render :index
    end
  end

  def search
    @results = @q.result
  end

  private
  
  def set_q
    @q = Clothe.includes(:brand_name).joins(:user).where(user: {role:1}).ransack(params[:q])
  end

end
