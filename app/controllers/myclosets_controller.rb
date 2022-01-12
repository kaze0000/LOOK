class MyclosetsController < ApplicationController
  before_action :set_q, only: [:search]
  def index
    @my_clothes = current_user.clothes.includes(:brand_name).order(created_at: :desc).page(params[:page])
    @selected_count = Clothe.where(selected: true, user_id: current_user.id).count
  end

  def new
    @brand_name = BrandName.new
    @clothe = @brand_name.build_clothe
  end
  
  def create
    @brand_name = BrandName.new(brand_name_params)
    if @brand_name.save
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
    @clothe = Clothe.find(params[:id])
    @brand_name = @clothe.brand_name
  end

  def update
    @clothe = Clothe.find(params[:id])
    @brand_name = @clothe.brand_name
    @brand_name.update(update_brand_name_params)
  end

  def destroy
    @clothe = Clothe.find(params[:id])
    @clothe.brand_name.destroy!
  end

  def search
    @results = @q.result.includes(:brand_name).joins(:user).where(user_id: current_user.id)
    @selected_count = Clothe.where(selected: true, user_id: current_user.id).count
  end

  def select
    @clothe = Clothe.find(params[:id])
    @clothe.update(select_params)
    @selected_count = Clothe.where(selected: true, user_id: current_user.id).count
  end
  
  private
  
  def set_q
    @q = Clothe.ransack(params[:q])
  end
  
  def select_params
    params.require(:clothe).permit(:selected)
  end

  def brand_name_params
    params.require(:brand_name).permit(:name, clothe_attributes:[:genre, :user_id, :image, :gender])
  end

  def update_brand_name_params
    params.require(:brand_name).permit(:id,:name,clothe_attributes:[:id, :genre, :gender])
  end
end
