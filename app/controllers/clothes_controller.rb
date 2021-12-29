class ClothesController < ApplicationController
  def index
    @clothes = Clothe.all
  end
end
