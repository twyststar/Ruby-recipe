class Ingredient < ActiveRecord::Base
  has_many :combos
  has_many :recipes, through: :combos
end
