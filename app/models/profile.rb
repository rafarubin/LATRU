class Profile < ApplicationRecord
  belongs_to :user
  before_create :assign_random_color
  has_many :historicals, dependent: :destroy

  validates :username, presence: true
  validates :username, length: { maximum: 12 }

  private

  def assign_random_color
  colors = ['#74D3AE', '#98b28d', '#A6C48A', '#F6E7CB', '#DD9787', '#62DDF5', '7FAFAC']
    color = colors.sample
  end
end
