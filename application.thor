require "coffee-script"

class Application < Thor
  include Thor::Actions
  
  desc "deploy", "prepare and deploy to heroku"
  def deploy
    javascript = CoffeeScript.compile File.read("views/application.coffee")
    create_file "public/application.js", javascript
    run "git commit -am 'Deploying to heroku'", :capture => true
    run "git push heroku master"
  end
end