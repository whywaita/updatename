# -*- coding: utf-8 -*-

require 'twitter'
require './key.rb'

# CS/CKを設定しているようだ
@rest_client = Twitter::REST::Client.new do |config|
	config.consumer_key	   = Const::CONSUMER_KEY
	config.consumer_secret     = Const::CONSUMER_SECRET
	config.access_token        = Const::ACCESS_TOKEN
	config.access_token_secret = Const::ACCESS_TOKEN_SECRET
end

# UserStreamはここで接続？
@stream_client = Twitter::Streaming::Client.new do |config|
	  config.consumer_key        = Const::CONSUMER_KEY
	  config.consumer_secret     = Const::CONSUMER_SECRET
	  config.access_token        = Const::ACCESS_TOKEN
	  config.access_token_secret = Const::ACCESS_TOKEN_SECRET
end


