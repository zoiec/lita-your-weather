# lita-your-weather

lita-your-weather provides the ability to ask for the current weather conditions or for a 7 day forecast. This gem uses the www.apixu.com api to get the current weather and a 7 day weather forecast.

## Installation

Add lita-your-weather to your Lita instance's Gemfile:

``` ruby
gem 'lita-your-weather'
```
`$ bundle install`

## Configuration

Obtain an API Key from www.apixu.com
Add the following to your lita_config.rb :

``` ruby
config.handlers.your_weather.default_location = 'City, State, Country'
config.handlers.your_weather.api_key = 'www.apixu.com Api Key'
```

## Usage

Commands include:

<!-- Current weather of default location -->
`$ lita weather`

`$ lita weather c`
<!-- Current weather of specified location-->
`$ lita weather c <location>`

<!-- Weather forecast of default location-->
`$ lita weather f`
<!-- Weather forecast of specified location-->
`$ lita weather f <location>`

<!-- Weather images from default location-->
`$ lita weather i <location>`
<!-- Weather images-->
`$ lita weather i <location>`
