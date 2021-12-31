class ClothesController < ApplicationController
  def index
    @clothes = Clothe.all.order(id: :desc)
    @clothes.update(selected: false) # ロード時にすべて選択を外す
  end

  # def update
  #   @clothe =  Clothe.find(params[:id])
    # if  @clothe.selected == false
    #   @clothe.update(selected: true)
    # else
    #   @clothe.update(selected: false)
    # end
    # redirect_to clothes_path
    # if @clothe.update(clothe_params)
    #   redirect_to clothes_path
    # else
    #   redirect_to clothes_path, notice: 'Error occurs'
    # end
  # end
  def update
    @clothe = Clothe.find(params[:id])
    @clothe.update(clothe_params)
  end

  private

  def clothe_params
    params.require(:clothe).permit(:selected)
  end
end
