class Micropost < ApplicationRecord
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :photos
  belongs_to :user

  def self.paginated(limit = 5, offset = 0)
    Micropost.order(updated_at: :desc).limit(limit).offset(offset)
  end

end
