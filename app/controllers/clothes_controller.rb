class ClothesController < ApplicationController
  before_action :set_q, only: [:search]

  def index
    @clothes = Clothe.joins(:user).where(user: {role: 1}, gender: 0).page(params[:page]) if params[:gender] === "0"
    @clothes = Clothe.joins(:user).where(user: {role: 1}, gender: 1).page(params[:page]) if params[:gender] === "1"
  end

  def set
    clothe = Clothe.find(params[:id])
    set_clothe = BrandName.new(name: clothe.brand_name.name, clothe_attributes: { genre: clothe.genre, user_id: current_user.id, image: clothe.image })
    if  set_clothe.save
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
