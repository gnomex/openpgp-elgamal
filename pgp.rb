require 'sinatra'
require 'json'
require 'gpgme'

require_relative 'lib/gpg/crypto'


module Helpers
  def plain(resource, code = 200)
    content_type 'text/plain'
    status code
    resource.to_s
  end

  def json(resource, code = 200)
    content_type :json
    status code
    resource.to_json
  end
end

disable :protection

helpers do
  include Helpers
end

before do
  headers 'Access-Control-Allow-Origin' => '*'
end

get '/' do
  message = GPG::Crypto.encrypt "Pão e cerveja!"
  # json message.to_s
  plain message
end
