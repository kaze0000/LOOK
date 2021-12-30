class ClothesController < ApplicationController
  def index
    @clothes = Clothe.find(1)
  end
end
