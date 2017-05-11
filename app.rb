require("bundler/setup")
Bundler.require(:default)
also_reload('lib/**/*.rb')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @tags = Tag.all()
  @recipes = Recipe.all()
  @ingredients = Ingredient.all()
  erb :index
end

post '/ingredient' do
  ingredient = Ingredient.new(:name => params[:name])
  ingredient.save()
  redirect "/"
end

get '/ingredient/:id' do
  @ingredient = Ingredient.find(params[:id])
  erb :ingredient
end

patch '/ingredient/:id' do
  ingredient = Ingredient.find(params[:id])
  ingredient.update({:quantity_available => params[:quantity], :quantity_units => params[:units]})
  redirect '/ingredient/'.concat(params[:id])
end

delete '/ingredient/:id' do
  ingredient = Ingredient.find(params[:id])
  Ingredient.where(id: params[:id]).destroy_all()
  redirect '/'
end

post '/recipe' do
  recipe = Recipe.new(:name => params[:name])
  recipe.save()
  redirect "/"
end

post '/tag' do
  tag = Tag.new(:name => params[:name])
  tag.save()
  redirect "/"
end

get '/recipe/:id' do
  @recipe = Recipe.find(params[:id])
  erb :recipe
end

get '/recipe/edit/:id' do
  @recipe = Recipe.find(params[:id])
  erb :recipe_edit
end

delete '/recipe/edit/:id/ingredient' do
  recipe = Recipe.find(params[:id])
  ingredient_ids = params[:ingredient_ids]
  ingredient_ids.each() do |id|
    ingredient = Ingredient.find(id)
    recipe.ingredients.destroy(ingredient)
  end
  redirect '/recipe/edit/'.concat(params[:id])
end

patch '/recipe/:id' do
  recipe = Recipe.find(params[:id])
  if params[:name] == ""
    name = recipe.name()
  else
    name = params[:name]
  end

  if params[:instructions] == ""
    instructions = recipe.instructions()
  else
    instructions = params[:instructions]
  end

  recipe.update({:name => name, :instructions => instructions})
  redirect '/recipe/edit/'.concat(params[:id])
end

patch '/recipe/:id/ingredient' do
  recipe = Recipe.find(params[:id])
  ingredient_ids = params[:ingredient_ids]

  ingredient_ids.each_with_index do |id, index|
    recipe.ingredients.push(Ingredient.find(id))

    combo = Combo.where(["recipe_id = ? and ingredient_id = ?", recipe.id, id])
    combo.update({:quantity_required => params[:quantity][index], :quantity_units => params[:units][index]})
  end
  redirect ('/recipe/edit/' + params[:id])
end

post '/recipe/:id/ingredient' do
  recipe = Recipe.find(params[:id])
  ingredient = recipe.ingredients.create({:name => params[:name]})

  combo = Combo.where(["recipe_id = ? and ingredient_id = ?", recipe.id, ingredient.id])
  combo.update({:quantity_required => params[:quantity].to_f, :quantity_units => params[:units]})

  redirect '/recipe/edit/'.concat(params[:id])
end

patch '/recipe/:id/tag' do
  recipe = Recipe.find(params[:id])
  tag_ids = params[:tag_ids]
  tag_ids.each do |id|
    recipe.tags.push(Tag.find(id))
  end
  redirect '/recipe/edit/'.concat(params[:id])
end

post '/recipe/:id/tag' do
  recipe = Recipe.find(params[:id])
  recipe.tags.push(Tag.new(:name => params[:name]))
  redirect '/recipe/edit/'.concat(params[:id])
end

get '/tag/:id' do
  @tag = Tag.find(params[:id])
  erb :tag
end

patch '/tag/:id' do
  tag = Tag.find(params[:id])
  tag.update({:name => params[:name]})
  redirect ('/tag/' + (params[:id]))
end
