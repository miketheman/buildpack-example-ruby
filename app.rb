#!/usr/bin/env ruby -I ../lib -I lib
require 'sinatra'
require 'statsd'

# Create a stats interface
$statsd = Statsd.new('localhost', 8125)

# Tell us which dyno this came from
$dyno_id ||= ENV['DYNO']

class App < Sinatra::Base
  get('/') do
    $statsd.increment('page.views', tags: ['app:example-app', "dyno_id:#{$dyno_id}"])
    "<center><h1>Welcome! The time now is: #{Time.now}"
  end
end
