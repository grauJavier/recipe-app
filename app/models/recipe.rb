class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods

  validates :name, presence: true, length: { maximum: 50 }
  validates :preparation_time, presence: true, numericality: { greater_than: 0 }
  validates :cooking_time, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :user_id, presence: true

  scope :public_recipes, -> { where(public: true) }
  scope :private_recipes, -> { where(public: false) }
  scope :by_user, ->(user_id) { where(user_id:) }
  scope :by_food, ->(food_id) { joins(:foods).where(foods: { id: food_id }) }

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
