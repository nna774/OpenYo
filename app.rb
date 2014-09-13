# -*- coding: utf-8 -*-
require 'rubygems'
require 'sinatra/base'
require 'sinatra/reloader'
require 'rack/rewrite'
require 'mysql2'

require_relative 'yo'
require_relative 'config'

module Portfolio
  class App < Sinatra::Base

    configure :development do
      register Sinatra::Reloader
      also_reload "#{File.dirname(__FILE__)}/yo.rb"
      also_reload "#{File.dirname(__FILE__)}/config.rb"
    end

    before do
      @database = Mysql2::Client.new(:host => DBHOST, :username => DBUSER, :password => DBPASS, :database => DBNAME)
    end
    
    get '/' do
      erb :top
    end
    post '/yo' do
      "please send to /yo/\n"
    end
    post '/yo/' do
      if params[:api_ver] == "0.1"
        return Yo::sendYo(@database, params[:api_token], params[:username])
      end
      "bad api_ver\n{0.1}\n"
    end
    get '/yo/' do
      redirect "/", 301
    end
    post '/yoall/' do
      if params[:api_ver] == "0.1"
        return Yo::yoAll(@database, params[:api_token])
      end
      "bad api_ver\n{0.1}\n"
    end
    get '/friends_count' do
      redirect "/friends_count/", 301
    end
    get '/friends_count/' do
      if params[:api_ver] == "0.1"
        return Yo::friends_count(@database, params[:api_token])
      end
      "bad api_ver\n{0.1}\n"
    end
    get '/list_friends' do
      redirect "/list_friends/", 301
    end
    get '/list_friends/' do
      if params[:api_ver] == "0.1"
        return Yo::list_friends(@database, params[:api_token])
      end
      "bad api_ver\n{0.1}\n"
    end
    get '/sender/:token' do
      @token = params[:token]
      erb :sender
    end
    post '/create_user/' do
      if params[:api_ver] == "0.1"
        return Yo::createUser(@database, params[:username])
      end
      "bad api_ver\n{0.1}\n"
    end
    post '/add_imkayac/' do
      if params[:api_ver] == "0.1"
        return Yo::addImkayac(@database, params[:api_token], params[:kayac_id], params[:kayac_pass], params[:kayac_sec])
      end
      "bad api_ver\n{0.1}\n"
    end
  end
end
