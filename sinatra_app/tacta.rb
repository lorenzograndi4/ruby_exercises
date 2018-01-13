require 'sinatra'
require './contacts_file'

set :port, 4567

get '/' do
  @contacts = read_contacts
  erb :'contacts/index'
end

get '/contacts/:i' do
  contacts = read_contacts
  @contact = contacts[params[:i].to_i]
  erb :'contacts/show'
end
