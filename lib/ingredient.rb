class Ingredient < ActiveRecord::Base
  has_many :combos
  has_many :recipes, through: :combos
  before_destroy :kill_all

private
  def kill_all
    self.recipes.delete_all
  end
end
