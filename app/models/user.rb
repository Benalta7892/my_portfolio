class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  has_one :resume, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_one_attached :avatar

  validates :bio, presence: true

  validates :links, presence: true
end
