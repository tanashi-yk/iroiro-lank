class Prediction < ApplicationRecord
  belongs_to :competition
  
  has_many :ranking_items, dependent: :destroy
  
  # フォームから子（ランキング項目）の情報も一緒に受け取れるようにする
  accepts_nested_attributes_for :ranking_items, allow_destroy: true
end