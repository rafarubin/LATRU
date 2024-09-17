class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :profiles
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  def initials
    email.split('@').first[0, 2].upcase
  end

end
