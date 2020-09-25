class Book < ApplicationRecord
  belongs_to :user
  validates :title, :author, :label, presence: true
  validates :title, :author, :label, length: { minimum: 1 }
end
