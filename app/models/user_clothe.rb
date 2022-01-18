class UserClothe < ApplicationRecord
  belongs_to :user
  belongs_to :clothe

  enum relation: { original: 0, replica: 1 }
  enum state: { published: 0, privated: 1 }

  scope :selected, -> (user_id){ where(selected: true, user_id: user_id) }
  scope :original, -> { where(relation: 0) }
  scope :published, -> { where(state: 0) }
  scope :mine_and_others_published, -> { where.not(relation: 1, state: 1 ) }
end
