class Record < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :user
  has_many_attached :images

  with_options presence: true do
    validates :title
    validates :category_id
    validates :date
    validates :place
    validates :text
    validates :status
  end

  validates :category_id, numericality: { other_than: 1 }

  enum status: { closed: 0, open: 1 }
end
