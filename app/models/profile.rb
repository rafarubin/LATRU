class Profile < ApplicationRecord
  belongs_to :user
  has_many :historicals, dependent: :destroy

  validates :username, presence: true
  validates :username, length: { maximum: 6 }

end
