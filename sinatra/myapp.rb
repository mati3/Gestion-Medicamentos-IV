require 'sinatra' 
require 'json'

  get '/' do
    content_type :json
	{:status => 'ok'}.to_json
  
  end

  

