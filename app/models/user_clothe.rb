class UserClothe < ApplicationRecord
  belongs_to :user
  belongs_to :clothe

  enum relation: { original: 0, replica: 1 }
  enum state: { published: 0, privated: 1 }

end
