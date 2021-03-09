class Record < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :title
    validates :category_id
    validates :date
    validates :place
    validates :status
  end

  validates :category_id, numericality: { other_than: 1 }

  enum status: { closed: 0, open: 1 }
end
