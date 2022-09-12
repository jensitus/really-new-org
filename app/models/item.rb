class Item < ApplicationRecord
  belongs_to :todo
  has_one :description
end
