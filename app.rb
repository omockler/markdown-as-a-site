require 'sinatra/base'
require 'octokit'

class MaaS < Sinatra::Base
  helpers do
    def client
      @client ||= Octokit::Client.new
    end
  end

  get '/' do 
    file = client.contents ENV["MAAS_REPO"], {:path => ENV["MAAS_PATH"]}
    text = Base64.decode64(file[:content])
    markdown = client.markdown text
    
    erb markdown, layout: :layout

    # To do your own .md parsing, simply add a .md gem (i.e. rdiscount, redcarpet)
    # markdown text, :layout_engine => :erb, :layout => :layout
  end
end

MaaS.run!