require 'json'

module Lita
  module Handlers
    class YourWeather < Handler
      # insert handler code here

      Lita.register_handler(self)

      # Variables
      URL = 'http://api.apixu.com/v1'
      config :default_location, type: String, required: true
      config :api_key, type: String, required: true

      # Routes
      route(/^weather\s{1}c\s*(.*)/, :weather_current, command: false, help: { "weather c CITY/CITY,COUNTRY" => "Responds with the specified city's current weather." })
      route(/^weather\s{1}f\s*(.*)/, :weather_forecast, command: false, help: { "weather f CITY/CITY,COUNTRY" => "Responds with the specified city's 7 day forecast." })

      # Current Weather
      def weather_current(response)

          location = response.matches[0][0]

          data = request('/current.json?key=' + config.api_key , 'c', location)

          if data['error']
            response.reply('The location does not exist or weather has exceeded the query limit error: ' + data['error']['message'])
          else
            response.reply( data['location']['name'] + ', ' + data['location']['region'] + ', ' + data['location']['country'] + ' currently is ' +  data['current']['condition']['text'] + ' and ' + data['current']['temp_c'].to_s + "\xC2\xB0" + 'C. It feels like ' + data['current']['feelslike_c'].to_s  + "\xC2\xB0" + 'C' )
          end
      end

      # Forecast Weather
      def weather_forecast(response)

          location = response.matches[0][0]

          data = request('/forecast.json?key=' + config.api_key + '&days=7', 'c', location)

          if data['error']
            response.reply('The location does not exist or weather has exceeded the query limit error: ' + data['error']['message'])
          else
            response.reply('The forecast for ' + data['location']['name'] + ', ' + data['location']['region'] + ', ' + data['location']['country'] + ':')
            data['forecast']['forecastday'].each do |object|
              # binding.pry
              response.reply('On ' + object['date'] + ' forecasted is a high of ' +  object['day']['maxtemp_c'].to_s + "\xC2\xB0" + 'C' + ' and a low of ' + object['day']['mintemp_c'].to_s + "\xC2\xB0" + 'C It is expected to be ' + object['day']['condition']['text'] )
            end

          end
      end

      # Request method
      def request(url, type, location)

        if location == ''
          location = config.default_location
        end

        http_response = http.get( URL + url, q: location)
        return JSON.parse(http_response.body)
      end

    end
  end
end
