class MyclosetsController < ApplicationController
  before_action :set_q, only: [:search]
  def index
    @user_clothes = current_user.user_clothes.includes(:clothe, clothe: [:brand_name]).where.not(relation: 1, state: 1).order(created_at: :desc).page(params[:page])
    @selected_count = UserClothe.where(selected: true, user_id: current_user.id).count
  end

  def new
    @brand_name = BrandName.new
    @clothe = @brand_name.build_clothe
  end
  
  def create
    @brand_name = BrandName.new(brand_name_params)
    if @brand_name.save
      clothe = @brand_name.clothe
      @user_clothe = UserClothe.new(user_id: current_user.id, clothe_id: clothe.id)
      @user_clothe.save
      # 背景削除の処理（開発中はコメントアウト）
      # clothe = @brand_name.clothe
      # result = RemoveBg.from_file("public/#{clothe.image.url}")
      # result.save("public/#{clothe.image.url}", overwrite: true)
      
      redirect_to myclosets_path
      flash[:alert] = '登録に成功しました。'
    else
      # TODO　else処理を考える　flashかなんか出す？
      redirect_to myclosets_path
      flash[:alert] = '登録に失敗しました。'
    end
  end
  
  def edit
    @user_clothe = UserClothe.find(params[:id])
    @brand_name = @user_clothe.clothe.brand_name
  end

  def update
    @clothe = Clothe.find(params[:id])
    @update_user_clothe = UserClothe.where(user_id: current_user, clothe_id: @clothe)
    @brand_name = @clothe.brand_name
    @brand_name.update(update_brand_name_params)
  end

  def destroy
    @user_clothe = UserClothe.find(params[:id])
    @user_clothe.destroy!
  end

  def search
    @results = @q.result.includes(:clothe, clothe: [:brand_name]).where(user_clothes: {user_id: current_user.id})
    @selected_count = UserClothe.where(selected: true, user_id: current_user.id).count
  end

  def select
    @user_clothe = UserClothe.find(params[:id])
    @user_clothe.update(select_params)
    @selected_count = UserClothe.where(selected: true, user_id: current_user.id).count
  end

  def publish
    @clothe = Clothe.find(params[:id])
    @clothe.user_clothes.update(publish_params)
    redirect_to myclosets_path
  end
  
  private
  
  def set_q
    @q = UserClothe.ransack(params[:q])
  end
  
  def select_params
    params.require(:user_clothe).permit(:selected)
  end

  def publish_params
    params.require(:user_clothe).permit(:state)
  end

  def brand_name_params
    params.require(:brand_name).permit(:name, clothe_attributes:[:category, :image, :gender])
  end

  def update_brand_name_params
    params.require(:brand_name).permit(:id,:name, clothe_attributes:[:id, :category, :gender])
  end
end
