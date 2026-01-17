class Event < ApplicationRecord
  has_many :predictions, dependent: :destroy
  validates :title, presence: true
end