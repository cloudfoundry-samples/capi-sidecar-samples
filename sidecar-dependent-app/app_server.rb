ENV['RACK_ENV'] ||= 'development'

require 'rubygems'
require 'sinatra/base'
require 'json'
require 'typhoeus'

Bundler.require :default, ENV['RACK_ENV'].to_sym

class AppServer < Sinatra::Base
  get '/' do
    "Hi, I'm an app with a sidecar!"
  end

  get '/config' do
    puts "Sending a request to the config-server sidecar at localhost:#{ENV['CONFIG_SERVER_PORT']}/config/"
    response = Typhoeus.get("localhost:#{ENV['CONFIG_SERVER_PORT']}/config/")
    puts "Received #{response.body} from the config-server sidecar"
    response.body
  end

  run! if app_file == $0
end
