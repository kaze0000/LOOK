class BrandName < ApplicationRecord
  has_one :clothe, dependent: :destroy
  accepts_nested_attributes_for :clothe, allow_destroy: true
  validates :name, presence: true
end
