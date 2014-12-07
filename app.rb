#!/usr/bin/env ruby -I ../lib -I lib
require 'sinatra'

class App < Sinatra::Base
  get('/') do
    "<center><h1>Welcome! The time now is: #{Time.now}"
  end
end
