# frozen_string_literal: true

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
      route(/^weather\s?[c?|f?|i?]?\s?(.*)/, :weather, command: true, help: { 'lita weather CITY,STATE,COUNTRY or lita weather c CITY,STATE,COUNTRY or lita weather f CITY,STATE,COUNTRY' => "Responds with the specified city's current weather or 7-day forecast." })

      # Current Weather
      def weather(response)
        location = get_location(response.matches[0][0])

        if response.message.body.include? 'weather f'
          data = request('/forecast.json?key=' + config.api_key + '&days=7', location)
        elsif response.message.body.include? 'weather i'
          if location.downcase.include? 'edmonton,alberta'
            response.reply('https://ssl.eas.ualberta.ca/sitecore/camera/live/camera-ne.jpg')
            response.reply('https://ssl.eas.ualberta.ca/sitecore/camera/live/camera-nw.jpg')
            response.reply('https://ssl.eas.ualberta.ca/sitecore/camera/live/camera-w.jpg')
          end
        else
          data = request('/current.json?key=' + config.api_key, location)
        end

        unless data.nil?
          return response.reply('Error: ' + data['error']['message']) if data['error']

          if response.message.body.include? 'weather f'
            response.reply('The forecast for ' + data['location']['name'] + ', ' + data['location']['region'] + ', ' + data['location']['country'] + ':')
            data['forecast']['forecastday'].each do |object|
              response.reply('On ' + object['date'] + ' forecasted is a high of ' + object['day']['maxtemp_c'].to_s + "\xC2\xB0" + 'C' + ' and a low of ' + object['day']['mintemp_c'].to_s + "\xC2\xB0" + 'C It is expected to be ' + object['day']['condition']['text'])
            end
          else
            response.reply('http:' + data['current']['condition']['icon'])
            response.reply(data['location']['name'] + ', ' + data['location']['region'] + ', ' + data['location']['country'] + ' currently is ' + data['current']['condition']['text'] + ' and ' + data['current']['temp_c'].to_s + "\xC2\xB0" + 'C. It feels like ' + data['current']['feelslike_c'].to_s + "\xC2\xB0" + 'C')
          end
        end
      end

      # Get location
      def get_location(location)
        location = config.default_location if location.eql? ''
        location
      end

      # Request method
      def request(url, location)
        http_response = http.get(URL + url, q: location)
        JSON.parse(http_response.body)
      end
    end
  end
end
