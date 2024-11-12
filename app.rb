require "sinatra"
require "sinatra/reloader"
require "http"
require "dotenv/load"

get("/") do
  
  all_currencies_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

  response = HTTP.get(all_currencies_url).to_s
  @data = JSON.parse(response)
  @all_currencies = @data.fetch("currencies").keys()

  erb(:home)
end

get("/:from_currency") do
  @root_currency = params.fetch("from_currency")

  all_currencies_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  response = HTTP.get(all_currencies_url).to_s

  @all_currencies = JSON.parse(response).fetch("currencies").keys()

  erb(:currency_to_convert)
end

get("/:from_currency/:to_currency") do
  @root_currency = params.fetch("from_currency")
  @target_currency = params.fetch("to_currency")

  convert_url = "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}&from=#{@root_currency}&to=#{@target_currency}&amount=1"

  response = HTTP.get(convert_url).to_s
  response_json = JSON.parse(response)
  @convert_result = response_json.fetch("result")

  erb(:result)
end
