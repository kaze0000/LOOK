class MyclosetsController < ApplicationController
  require 'base64'

  before_action :require_login
  def index
    @my_clothes = current_user.clothes
    @my_clothes.update(selected: false) # ロード時にすべて選択を外す
    @brand_name = BrandName.new
    @clothes = @brand_name.clothes.build
  end

  def create
    @brand_name = BrandName.new(brand_name_params)
    if @brand_name.save

      # 背景削除の処理
      @brand_name.clothes.each do |clothe|
        # encoded = Base64.encode64(clothe.image_identifier)
        # decoded = Base64.decode64(encoded)
        # ->ファイル名に日本語が入るとうまくデコードされない
        
        result = RemoveBg.from_file("public/#{clothe.image.url}")
        # result = RemoveBg.from_file(Base64.decode64("public/#{decode}}"))
        result.save("public/#{clothe.image.url}", overwrite: true) 
      end
      redirect_to myclosets_path
    else
      # TODO　else処理を考える　flashかなんか出す？
      redirect_to clothes_path
    end
  end

  private

  def brand_name_params
    params.require(:brand_name).permit(:name, clothes_attributes:[:genre, :user_id, :image])
  end

end
