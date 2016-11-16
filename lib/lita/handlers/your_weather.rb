module Lita
  module Handlers
    class YourWeather < Handler
      # insert handler code here

      Lita.register_handler(self)

      # API
      # https://api.apixu.com/v1/current.json?key=3c71764fa29246acaf164605161611&q=Paris

      route(/^echo\s+(.+)/, :echo, command: true, help: {
        "echo TEXT" => "Replies back with TEXT."
      })
    end
  end
end
