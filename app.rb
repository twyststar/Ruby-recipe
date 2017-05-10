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
  @ingredient = Ingredient.new(:name => params[:name])
  if @ingredient.save()
    redirect("/")
  else

  end
end

post '/recipe' do
  @recipe = Recipe.new(:name => params[:name])
  if @recipe.save()
    redirect("/")
  else

  end
end

post '/tag' do
  @tag = Tag.new(:name => params[:name])
  if @tag.save()
    redirect("/")
  else

  end
end

get '/recipe/:id' do
  @recipe = Recipe.find(params[:id])
  erb :recipe
end

patch '/recipe/:id' do
  @recipe = Recipe.find(params[:id])
  if params[:name] == ""
    name = @recipe.name()
  else
    name = params[:name]
  end

  if params[:instructions] == ""
    instructions = @recipe.instructions()
  else
    instructions = params[:instructions]
  end

  @recipe.update({:name => name, :instructions => instructions})
  erb :recipe
end

patch '/recipe/:id/ingredient' do
  @recipe = Recipe.find(params[:id])
  ingredient_ids = params[:ingredient_ids]
  ingredient_ids.each do |id|
    @recipe.ingredients.push(Ingredient.find(id))
  end
  erb :recipe
end

post '/recipe/:id/ingredient' do
  @recipe = Recipe.find(params[:id])
  @recipe.ingredients.push(Ingredient.new(:name => params[:name]))
  erb :recipe
end
