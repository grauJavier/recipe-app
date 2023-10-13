class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :recipes, through: :recipe_foods

  validates :name, presence: true, length: { maximum: 50 }
  validates :measurement_unit, presence: true, length: { maximum: 15 }
  validates :price, presence: true, numericality: { greater_or_equal_than: 0 }
  validates :quantity, presence: true, numericality: { greater_or_equal_than: 0 }
  validates :user_id, presence: true
end
