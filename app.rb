# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'json'

get "/" do
  erb :home
end


class Case < ActiveRecord::Base
  self.table_name = 'salesforce.case'
end

get "/cases" do
 @cases = Case.all
 erb :index
end

get "/api/cases" do
  content_type :json
  { data: Case.all}.to_json
end

get "/create" do
  dashboard_url = 'https://dashboard.heroku.com/'
  match = /(.*?)\.herokuapp\.com/.match(request.host)
  dashboard_url << "apps/#{match[1]}/resources" if match && match[1]
  redirect to(dashboard_url)
end
