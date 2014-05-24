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

def update_name(status)

	if status.text.include?("(@whywaita)") then
		text = status.text.sub("(@whywaita)","")
		text = text.sub("@","")

		if text && text.length > 20 then
			return
		end

	@rest_client.update_profile(:name => "#{text}")
	opt = {"in_reply_to_status_id" => status.id.to_s}
	tweet = "@#{status.user.screen_name} #{text}になったよ"
	@rest_client.update tweet,opt
	end

end

@stream_client.user do |object|
	next unless object.is_a? Twitter::Tweet
	unless object.text.start_with? "RT"
		update_name(object)
	end
end

