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

	if status.text.include?("@whywaita update_name") then
		text = status.text.sub("@whywaita update_name","")
		# text = text.sub("@","")

		# 長いのを弾く
		if text && text.length > 20 then
			tmp = {"in_reply_to_status_id" => status.id.to_s}
			longtweet = "@#{status.user.screen_name} 入りきらないよぉ…"
			@rest_client.update longtweet,tmp
			return
		end

		# 名前は空白に出来ないんじゃ
		if text && text.length == 0 then
			tmp = {"in_reply_to_status_id" => status.id.to_s}
			shorttweet = "@#{status.user.screen_name} 空白名は設定出来ません＞＜"
			@rest_client.update shorttweet,tmp
			return
		end


	# 名前を変更する
	@rest_client.update_profile(:name => "#{text}")
	opt = {"in_reply_to_status_id" => status.id.to_s}
	tweet = ".@#{status.user.screen_name} #{text}になったよ"
	@rest_client.update tweet,opt
	end

	# 元に戻すんじゃ
	if status.text.include?("@whywaita def") then
		text = status.text.sub("@whywaita def","")
		text = text.sub("@","")

	@rest_client.update_profile(:name => "why/橘和板")
	opt = {"in_reply_to_status_id" => status.id.to_s}
	tweet = "@#{status.user.screen_name} 戻ったよ"
	@rest_client.update tweet,opt
	end


end

# 動け
@stream_client.user do |object|
	next unless object.is_a? Twitter::Tweet
	unless object.text.start_with? "RT"
		update_name(object)
	end
end

