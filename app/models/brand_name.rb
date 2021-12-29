class BrandName < ApplicationRecord
  has_many :brand_names, dependent: :destroy

  validates :name, presence: true
end
