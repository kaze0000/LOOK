class MyclosetsController < ApplicationController
  # before_action :require_login
  def index
    @my_clothes = current_user.clothes
    # ロード時にすべて選択を外す
    @my_clothes.update(selected: false)
    # 以下で、new 処理のためのインスタンス作成
    @brand_name = BrandName.new
    @clothe = @brand_name.build_clothe
  end

  def edit
    @clothe = Clothe.find(params[:id])
    @brand_name = @clothe.brand_name
  end

  def create
    @brand_name = BrandName.new(brand_name_params)
    if @brand_name.save

      # # 背景削除の処理（開発中はコメントアウト、一人1回/月にしたい）
      # @brand_name.clothes.each do |clothe|
      #   # encoded = Base64.encode64(clothe.image_identifier)
      #   # decoded = Base64.decode64(encoded)
      #   # ->ファイル名に日本語が入るとうまくデコードされない
        
      #   result = RemoveBg.from_file("public/#{clothe.image.url}")
      #   # result = RemoveBg.from_file(Base64.decode64("public/#{decode}}"))
      #   result.save("public/#{clothe.image.url}", overwrite: true) 
      # end
      redirect_to myclosets_path
    else
      # TODO　else処理を考える　flashかなんか出す？
      redirect_to clothes_path
    end
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

  private

  def brand_name_params
    params.require(:brand_name).permit(:name, clothe_attributes:[:genre, :user_id, :image])
  end

  def update_brand_name_params
    params.require(:brand_name).permit(:id,:name,clothe_attributes:[:id, :genre])
  end
end
