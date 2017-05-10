require('spec_helper')

describe(Recipe) do
  it("has many tags") do
    recipe = Recipe.create({:name => "recipe"})
    tag1 = Tag.create({:name => "tag1"})
    tag2 = Tag.create({:name => "tag2"})
    recipe.tags.push([tag1, tag2])
    expect(recipe.tags()).to(eq([tag1, tag2]))
  end

  it("has many ingredients") do
    recipe = Recipe.create({:name => "recipe"})
    ingredient1 = Ingredient.create({:name => "ingredient1"})
    ingredient2 = Ingredient.create({:name => "ingredient2"})
    recipe.ingredients.push([ingredient1])
    expect(recipe.ingredients()).to(eq([ingredient1]))
  end
end
