class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :records


  validates :name, presence: true

  def self.guest
    find_or_create_by!(name: 'guestname') do |user|
      user.email = 'guest@sample.com'
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
