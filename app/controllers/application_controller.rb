require "Pry"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

    redirect '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    id = @recipe.id.to_s
    redirect '/recipes/' + id
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    Recipe.update(params[:id], :name => params["name"], :ingredients => params["ingredients"], :cook_time => params["cook_time"])
    id = @recipe.id.to_s
    redirect '/recipes/' + id
  end

  delete '/recipes/:id/delete' do
    Recipe.delete(params[:id])
    redirect '/recipes'
  end

end