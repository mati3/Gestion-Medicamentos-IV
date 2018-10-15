require 'rubygems'
require 'sinatra'
require 'bundler'

Bundler.require

require './sinatra/myapp' 
run Sinatra::Application 
