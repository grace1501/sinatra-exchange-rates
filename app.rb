require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  
  all_currencies_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

  response = HTTP.get(all_currencies_url).to_s
  @data = JSON.parse(response)

  erb(:home)
end
