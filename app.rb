require "sinatra"
require "haml"
require "coffee-script"

get "/" do
  @skill_groups = {
    "Athletik" => ["Akrobatik", "Klettern", "Laufen", "Schwimmen"],
    "Biotech" => ["Erste Hilfe", "Kybernetik", "Medizin"],
    "Elektronik" => ["Computer", "Datensuche", "Hardware", "Software"],
    "Feuerwaffen" => ["Gewehre", "Pistolen", "Schnellfeuerwaffen"],
    "Heimlichkeit" => ["Beschatten", "Fingerfertigkeit", "Infiltration", "Verkleiden"],
    "Mechanik" => ["Fahrzeugmechanik", "Industriemechanik", "Luftfahrmechanik", "Seefahrtmechanik"],
    "Nahkampf" => ["Klingenwaffen", "Knueppel", "Waffenloser Kampf"],
    "Natur" => ["Navigation", "Spurenlesen", "Survival"],
    "Cracken" => ["Elektronische Kriegsfuehrung", "Hacking", "Matrixkampf"],
    "Einfluss" => ["Fuehrung", "Gebraeuche", "Ueberreden", "Verhandlung"]
  }
  haml :index 
end

get "/coffee.js" do
  coffee :application
end

get "/style.css" do
  sass :style
end