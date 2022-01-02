class BrandName < ApplicationRecord
  has_many :clothes, dependent: :destroy
  accepts_nested_attributes_for :clothes, allow_destroy: true
  validates :name, presence: true
end
