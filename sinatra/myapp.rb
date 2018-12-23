require 'sinatra/base'
require 'rubygems'
require 'sinatra'
require 'json'
require 'logger'
require_relative  '../src/medicamento_uno'
require_relative  '../src/almacen'

set :logger, #Logger.new("STDOUT")

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
	file = File.read('src/UnMedicamento.json') 
    data_hash = JSON.parse(file)
    @medicamento = Medicamento.new(data_hash['nombre'], data_hash['prospecto'], data_hash['caducidad'], data_hash['identificador'])
    ############################### ALMACEN ######################
    
    file2 = File.read('src/TodosLosMedicamentos.json')
    data_hash2 = JSON.parse(file2)
    @medicamentos = []
    i=0
    data_hash2.each do |value|
    	@medicamentos[i] = Medicamento.new(value['nombre'], value['prospecto'], value['caducidad'], value['identificador'])
    	i=i+1
    end
    @almacen = Almacen.new(@medicamentos)
    ############################################################
  end

  get '/' do
    content_type :json
	{:status => 'ok'}.to_json
  
  end
  
  get '/status' do
  	#redirect '/'
  	content_type :json
	{:status => 'ok'}.to_json
  end
   
  get '/medicamento' do
  	content_type :json
  	@medicamento
  	erb :medicamento
  end
  
  get '/listaMedicamentos' do
  	content_type :json
  	@almacen
  	erb :almacen
  end
  
    get '/nombres' do
  	content_type :json
  	@almacen
  	erb :nombres
  end
  
  run!
  
end
  

