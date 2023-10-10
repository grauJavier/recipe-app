# == Schema Information
#
# Table name: foods
#
#  id               :bigint           not null, primary key
#  name             :string(50)       not null
#  measurement_unit :string(15)       not null
#  price            :float            not null
#  quantity         :integer          not null
#  user_id          :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :recipes, through: :recipe_foods

  validates :name, presence: true, length: { maximum: 50 }
  validates :measurement_unit, presence: true, length: { maximum: 15 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :user_id, presence: true
end
