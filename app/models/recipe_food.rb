# == Schema Information
#
# Table name: recipe_foods
#
#  id         :bigint           not null, primary key
#  quantity   :integer          not null
#  recipe_id  :bigint           not null
#  food_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :recipe_id, presence: true
  validates :food_id, presence: true
end
