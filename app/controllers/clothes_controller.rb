class ClothesController < ApplicationController
  def index 
    @clothes = Clothe.where(admin_clothe: true, gender: 0).page(params[:page]) if params[:gender] === "0"
    @clothes = Clothe.where(admin_clothe: true, gender: 1).page(params[:page]) if params[:gender] === "1"
  end

  def set
    clothe = Clothe.find(params[:id])
    set_clothe = BrandName.new(name: clothe.brand_name.name, clothe_attributes:{genre:clothe.genre,user_id:current_user.id,image: clothe.image})
    if  set_clothe.save
      redirect_to myclosets_path
    else
      render :index
    end
  end
end
