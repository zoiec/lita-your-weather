require 'json'

module Lita
  module Handlers
    class YourWeather < Handler
      Lita.register_handler(self)

      # Variables
      URL = 'http://api.apixu.com/v1'
      config :default_location, type: String, required: true
      config :api_key, type: String, required: true

      # Routes
      route(/^weather\s{1}*(.*)/, :weather_current, command: false, help: { "weather CITY/STATE,COUNTRY" => "Responds with the specified city's current weather." })
      route(/^weather\s{1}c\s*(.*)/, :weather_current, command: false, help: { "weather c CITY/STATE,COUNTRY" => "Responds with the specified city's current weather." })
      route(/^weather\s{1}f\s*(.*)/, :weather_forecast, command: false, help: { "weather f CITY/STATE,COUNTRY" => "Responds with the specified city's 7 day forecast." })

      # Current Weather
      def weather_current(response)
          location = get_location(response.matches[0][0])
          data = request('/current.json?key=' + config.api_key , location)

          if data['error']
            response.reply('Error: ' + data['error']['message'])
          else
            response.reply( data['location']['name'] + ', ' + data['location']['region'] + ', ' + data['location']['country'] + ' currently is ' +  data['current']['condition']['text'] + ' and ' + data['current']['temp_c'].to_s + "\xC2\xB0" + 'C. It feels like ' + data['current']['feelslike_c'].to_s  + "\xC2\xB0" + 'C' )

            if location.downcase.include? "edmonton"
              response.reply('https://ssl.eas.ualberta.ca/sitecore/camera/live/camera-ne.jpg')
              response.reply('https://ssl.eas.ualberta.ca/sitecore/camera/live/camera-nw.jpg')
              response.reply('https://ssl.eas.ualberta.ca/sitecore/camera/live/camera-w.jpg')
            end
          end
      end

      # Forecast Weather
      def weather_forecast(response)
          location = get_location(response.matches[0][0])
          data = request('/forecast.json?key=' + config.api_key + '&days=7', location)

          if data['error']
            response.reply('Error: ' + data['error']['message'])
          else
            response.reply('The forecast for ' + data['location']['name'] + ', ' + data['location']['region'] + ', ' + data['location']['country'] + ':')
            data['forecast']['forecastday'].each do |object|
              # binding.pry
              response.reply('On ' + object['date'] + ' forecasted is a high of ' +  object['day']['maxtemp_c'].to_s + "\xC2\xB0" + 'C' + ' and a low of ' + object['day']['mintemp_c'].to_s + "\xC2\xB0" + 'C It is expected to be ' + object['day']['condition']['text'] )
            end
          end
      end

      # Get location
      def get_location(location)
        if location.eql? ''
          location = config.default_location
        end
        location
      end

      # Request method
      def request(url, location)
        http_response = http.get( URL + url, q: location)
        return JSON.parse(http_response.body)
      end
    end
  end
end
