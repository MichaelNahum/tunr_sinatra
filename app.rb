require 'bundler/setup'
require 'pry'
require 'pg'

require 'sinatra'
require 'sinatra/reloader'
require 'active_record'

# Load the file to connect to the DB
require_relative 'db/connection'

# Load models
require_relative 'models/artist'
require_relative 'models/song'


get '/' do
  "hello world"
end

get '/songs' do
  @songs = Song.all
  "hello world"
  erb :"songs/index"
end

get '/artists' do
  @artists = Artist.all
  "hello world"
  erb :"artists/index"
end

get '/artists/new' do
  erb :'artists/new'
end

post '/artists/new' do
  @artist = Artist.create(params[:artist])
  redirect :"/artists/#{@artist.id}"
end

get '/artists/:id' do
  @artist = Artist.find(params[:id])
  erb :"artists/show"
end

get "/artists/:id/edit" do
  @artist = Artist.find(params[:id])
  erb(:"artists/edit")
end

put '/artists/:id' do
  @artist = Artist.find(params[:id])
  @artist.update(params[:artist])
  redirect :"/artists/#{@artist.id}" #doesn't work, despite being identical to line 39 (which works fine)
end

delete '/artists/:id' do
  @artist = Artist.find(params[:id])
  @artist.destroy
  redirect :"/artists"
end
