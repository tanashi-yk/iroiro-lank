class Competition < ApplicationRecord
  # dependent: :destroy を追加して、予想データも一緒に消えるようにします
  has_many :predictions, dependent: :destroy
  
  # 色の配列保存の設定（そのまま残します）
  serialize :answer_colors, type: Array, coder: JSON
end