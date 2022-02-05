class FittingsController < ApplicationController
  skip_before_action :require_login, only: %i[secret]

  def index
    @selected_bottoms = Clothe.joins(:user_clothes).bottoms.merge(UserClothe.selected(current_user))
    @selected_tops = Clothe.joins(:user_clothes).tops.merge(UserClothe.selected(current_user))
    @fitting = Fitting.new
    @fitting_number = params[:fitting_number]
    if @fitting_number.present?
      @tweet_item = Fitting.find(@fitting_number)
    end
  end

  def create
    @fitting = Fitting.new(fitting_params)
    if @fitting.save
      # s3に保存
      file = File.new("public/#{@fitting.image.url}")
      s3 = Aws::S3::Resource.new
      obj = s3.bucket('look-closet').object("fitting/#{@fitting.id}.png")
      obj.upload_file(file.path, acl: 'public-read')
      redirect_to fittings_path(fitting_number: @fitting.id)
      flash[:alert] = '保存に成功しました'
    else
      redirect_to fitting_myclosets_path
      flash[:alert] = '保存に失敗しました'
    end
  end

  def secret
    @tweet_item = Fitting.find(params[:id])
  end

  private
  
  def fitting_params
    params.require(:fitting).permit(:user_id, :image)
  end
  
end
