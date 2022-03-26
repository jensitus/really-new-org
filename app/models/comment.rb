class Comment < ApplicationRecord
  has_one :micropost
  has_one :photo
end
