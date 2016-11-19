module Lita
  module Handlers
    class YourWeather < Handler
      # insert handler code here

      Lita.register_handler(self)

      # API
      # https://api.apixu.com/v1/current.json?key=3c71764fa29246acaf164605161611&q=Paris

      route(/^weather\s+(.+)/, :weather_response, command: true, help: {
        "weather CITY or CITY,COUNTRY" => "Responds back with weather."
      })

      def weather_response(response)
          http_response = http.get("https://api.apixu.com/v1/current.json?key=3c71764fa29246acaf164605161611", q: response.matches[0][0])
          data = http_response.body;

          response.reply(data)
          # http_response.body
          binding.pry
      end

    end
  end
end
