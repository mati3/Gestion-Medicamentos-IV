require 'sinatra/base' 
require 'json'

class MyApp < Sinatra::Base
  get '/' do
    content_type :json
	{:status => 'ok'}.to_json
  
  end
  
  run!
  
end
  

