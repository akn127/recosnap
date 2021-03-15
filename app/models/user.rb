class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :records, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true

  PASSWORD_REGEX = /(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}/i
  validates :password, format: { with: PASSWORD_REGEX, message: 'は半角英数字で入力してください' }

end
