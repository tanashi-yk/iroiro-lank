class RankingItem < ApplicationRecord
  belongs_to :prediction
  # rank（順位）や color_code（色）のバリデーションを後で追加してもいいですね！
end