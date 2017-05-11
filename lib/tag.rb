class Tag < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)

  def not_recipes
    all_recipes = Recipe.all()
    tag_recipes = self.recipes()
    not_recipes = all_recipes - tag_recipes
  end
end
