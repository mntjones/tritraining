require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :database_file, 'config/database.yml'
  end

  get '/' do
    erb :welcome
  end
  
 # HELPERS ---------
  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
      if !@current_user
			 @current_user = User.find(session[:user_id])
      else
        @current_user
      end
		end
	end

end
