# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string(20)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :recipes
  has_many :foods

  validates :name, presence: true, length: { maximum: 20 }
end
