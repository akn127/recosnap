class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :record

  validates_uniqueness_of :record_id, scope: :user_id
end
