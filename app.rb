require "sinatra"
require "haml"
require "coffee-script"

get "/" do
  haml :index 
end

get "/application.js" do
  coffee :application
end

get "/style.css" do
  sass :style
end