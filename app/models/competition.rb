class Competition < ApplicationRecord
  has_many :predictions
  
  # これを追記：色の配列をそのまま保存・復元できるようにします
  serialize :answer_colors, type: Array, coder: JSON
end