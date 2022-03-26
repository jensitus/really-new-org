class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :lockable

  mount_uploader :avatar, AvatarUploader

  has_many :microposts
  has_many :photo_gallery_users
  has_many :photo_galleries, through: :photo_gallery_users

end
