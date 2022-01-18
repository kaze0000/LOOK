class MyclosetsController < ApplicationController
  before_action :set_q, only: %i[search]
  before_action :set_user_clothe, only: %i[edit destroy select]
  before_action :set_clothe, only: %i[update publish]
  def index
    @user_clothes = current_user.user_clothes.includes(:clothe, clothe: [:brand_name]).mine_and_others_published.order(created_at: :desc).page(params[:page])
    @selected_count = UserClothe.selected(current_user).count
  end

  def new
    @brand_name = BrandName.new
    @clothe = @brand_name.build_clothe
  end
  
  def create
    @brand_name = BrandName.new(brand_name_params)
    if @brand_name.save
      clothe = @brand_name.clothe
      user_clothe = UserClothe.new(user_id: current_user.id, clothe_id: clothe.id)
      user_clothe.save
      # 背景削除の処理
      result = RemoveBg.from_file("public/#{clothe.image.url}")
      result.save("public/#{clothe.image.url}", overwrite: true)
      # s3に保存
      file = File.new("public/#{clothe.image.url}")
      s3 = Aws::S3::Resource.new
      obj = s3.bucket('look-closet').object("#{clothe.id}.png")
      obj.upload_file(file.path, acl: 'public-read')

      redirect_to myclosets_path
      flash[:alert] = '登録に成功しました。'
    else
      redirect_to myclosets_path
      flash[:alert] = '登録に失敗しました。'
    end
  end
  
  def edit
    @brand_name = @user_clothe.clothe.brand_name
  end
  
  def destroy
    @user_clothe.destroy!
  end

  def update
    @brand_name = @clothe.brand_name
    @brand_name.update(update_brand_name_params)
  end

  def search
    @results = @q.result.includes(:clothe, clothe: [:brand_name]).where(user_clothes: {user_id: current_user.id})
    @selected_count = UserClothe.selected(current_user).count
  end

  def select
    @user_clothe.update(select_params)
    @selected_count = UserClothe.selected(current_user).count
  end

  def publish
    clothe.user_clothes.update(publish_params)
    redirect_to myclosets_path
  end
  
  private
  
  def set_q
    @q = UserClothe.ransack(params[:q])
  end

  def set_user_clothe
    @user_clothe = UserClothe.find(params[:id])
  end

  def set_clothe
    @clothe = Clothe.find(params[:id])
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
    params.require(:brand_name).permit(:id, :name, clothe_attributes:[:id, :category, :gender])
  end
end
