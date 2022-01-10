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
      # # 背景削除の処理（開発中はコメントアウト、一人1回/月にしたい）
      # @brand_name.clothes.each do |clothe|
      #   # encoded = Base64.encode64(clothe.image_identifier)
      #   # decoded = Base64.decode64(encoded)
      #   # ->ファイル名に日本語が入るとうまくデコードされない
      
      #   result = RemoveBg.from_file("public/#{clothe.image.url}") これと
      #   # result = RemoveBg.from_file(Base64.decode64("public/#{decode}}"))
      #   result.save("public/#{clothe.image.url}", overwrite: true) これでうまくいく　日本語でも大丈夫だったっけ？
      # end
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
    @clothe.destroy!
  end

  def search
    @results = @q.result.includes(:brand_name).joins(:user).where(user_id: current_user.id, user: {role: 0})
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
    params.require(:brand_name).permit(:name, clothe_attributes:[:genre, :user_id, :image])
  end

  def update_brand_name_params
    params.require(:brand_name).permit(:id,:name,clothe_attributes:[:id, :genre])
  end
end
