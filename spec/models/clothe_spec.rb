require 'rails_helper'

RSpec.describe Clothe, type: :model do
  let(:clothe) { create(:clothe) }

  describe 'バリデーション確認' do
    fit 'imageが未入力ではclotheが作成できないこと' do
      clothe = Clothe.new
      expect(clothe.valid?).to be false
      binding.irb
    end
  end

end
