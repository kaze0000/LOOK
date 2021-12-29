class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :clothes, dependent: :destroy

  validates :name, presence: true, length: { maximum:255 }
  validates :email, uniqueness: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
end
