require 'socket'
require 'yaml'
require './config/routes.rb'
require './lib/routing.rb'

app_configs = YAML.load_file('config/application-config.yml')


server = TCPServer.new app_configs['network']['port'].to_i
puts "server started on #{app_configs['network']['port']}"

dispatcher = Routing::RouteMapping.new server, ROUTES
dispatcher.observe_and_map 