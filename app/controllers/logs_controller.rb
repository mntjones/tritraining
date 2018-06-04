require 'pry'
require 'rack-flash'

class LogsController < ApplicationController
  
  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views") }
    use Rack::Flash
  end

	get '/logs' do
    if !logged_in?
    	# error message - You must Log In!
    	flash[:message] = "You must Log In!"
      redirect '/login'
    else
      @user = current_user
      @logs = Log.all
      binding.pry
      erb :'/logs/log_list'
    end
  end

  get '/logs/new' do
    if logged_in?
      erb :'/logs/create_log'
    else
    	# error message - You must Log In!
    	flash[:message] = "You must Log In!"
      redirect '/login'
    end
  end

  post '/logs' do

    @user = current_user

    if params[:date] != ""
    	if params[:swim_distance] = "" && params[:bike_distance] == "" && params[:run_distance] == ""
    		flash[:message] = "Please enter at least 1 activity distance to save."
    		redirect 'logs/new'
    	end

			log = Log.create(date: params[:date])
    	if params[:swim_distance] != ""
    		log.swim_distance = params[:swim_distance]
    	else
    		log.swim_distance = 0
    	end

    	if params[:bike_distance] != ""
    		log.bike_distance = params[:bike_distance]
    	else
    		log.bike_distance = 0
    	end

    	if params[:run_distance] != ""
    		log.run_distance = params[:run_distance]
    	else
    		log.run_distance = 0
    	end
			
    	log.user = @user
    	log.save
    	flash[:message] = "Log saved Successfully"
    	redirect '/logs'
    else
    	flash[:message] = "Please enter a date (YYYY/MM/DD)"
    	redirect '/logs/new'
    end
  end

  get '/logs/:id' do
  	@user = current_user
  	@log = Log.find_by(id: params[:id])
  	binding.pry
    if logged_in? && @user == @log.user
      
      erb :'/logs/show_log'
    else
    	flash[:message] = "You must Log In!"
    	# error message - You must Log In!
      redirect '/login'
    end
  end

  get '/logs/:id/edit' do

    if logged_in?
      @log = Log.find_by(params[:id])
      erb :'/logs/edit_log'
    else
    	flash[:message] = "You must Log In!"
    	# error message - You must Log In!
      redirect '/login'
    end
  end

  patch '/logs/:id' do
    @log = Log.find_by(params[:id])

    if params[:date] != ""
    	if params[:swim_distance] = "" && params[:bike_distance] == "" && params[:run_distance] == ""
    		flash[:message] = "Please enter at least 1 activity distance to save."
    		redirect 'logs/:id/edit'
    	end

			@log = Log.update(date: params[:date])
    	if params[:swim_distance] != ""
    		@log.swim_distance = params[:swim_distance]
    	else
    		@log.swim_distance = 0
    	end

    	if params[:bike_distance] != ""
    		@log.bike_distance = params[:bike_distance]
    	else
    		@log.bike_distance = 0
    	end

    	if params[:run_distance] != ""
    		@log.run_distance = params[:run_distance]
    	else
    		@log.run_distance = 0
    	end

    	@log.save
    	flash[:message] = "Log updated Successfully"

    	redirect '/logs/#{@log.id}'
    else
    	flash[:message] = "Enter date to Update"
      redirect to "/logs/#{@log.id}/edit"
    end
  end

  delete '/logs/:id/delete' do
    @log = Log.find_by(params[:id])
    if @log.user == current_user
      Log.delete(params[:id])
      flash[:message] = "Log has been deleted."
      redirect '/logs'
    else
    	# error message - You must Log In!
    	flash[:message] = "You must Log In!"
      redirect '/login'
    end
  end
end