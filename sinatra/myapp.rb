require 'sinatra/base'
require 'rubygems'
require 'sinatra'
require 'json'
require 'logger'
require_relative  '../src/funciones'

set :logger, Logger.new("STDOUT")

class MyApp < Sinatra::Base

::Logger.class_eval { alias :write :'<<' }
  access_log = ::File.join(::File.dirname(::File.expand_path(__FILE__)),'log','access.log')
  access_logger = ::Logger.new(access_log)
  error_logger = ::File.new(::File.join(::File.dirname(::File.expand_path(__FILE__)),'log','error.log'),"a+")
  error_logger.sync = true
 
  configure do
    use ::Rack::CommonLogger, access_logger
  end


  before do
  	env["rack.errors"] =  error_logger
    content_type 'application/json'
	file = File.read('src/medicamentos.json')
    data_hash = JSON.parse(file)
    @medicamento = Medicamento.new(data_hash['nombre'], data_hash['prospecto'], data_hash['caducidad'], data_hash['identificador'])
  end

  get '/' do
    content_type :json
	{:status => 'ok'}.to_json
  
  end

  
  get '/medicamento' do
  	content_type :json
  	@medicamento
  	erb :medicamento
  end
  
  run!
  
end
  

