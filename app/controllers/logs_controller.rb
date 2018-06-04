require 'pry'

class LogsController < ApplicationController
  
  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views") }
  end

	get '/logs' do
    if !logged_in?
    	# error message - You must Log In!
      redirect '/login'
    else
      @user = current_user
      @logs = Log.all
      erb :'/logs/log_list'
    end
  end

  get '/logs/new' do
    if logged_in?
      erb :'/logs/create_log'
    else
    	# error message - You must Log In!
      redirect '/login'
    end
  end

  post '/logs' do
    @user = current_user

    if params[:date] != ""
    	if params[:swim_distance] = "" && params[:bike_distance] == "" && params[:run_distance] == ""
    		#error message - Please enter at least 1 activity distance!
    		redirect 'logs/new'
    	end

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

			log = Log.create(date: params[:date])
    	log.user = @user
    	log.save

    	redirect '/logs'
    else
    	# error message - Please enter date!
    	redirect '/logs/new'
    end
  end

  get '/logs/:id' do
    if logged_in?
      @log = Log.find_by_id(params[:id])
      erb :'/logs/show_log'
    else
    	# error message - You must Log In!
      redirect '/login'
    end
  end

  get '/logs/:id/edit' do
    if logged_in?
      @log = Log.find(params[:id])
      erb :'/logs/edit_log'
    else
    	# error message - You must Log In!
      redirect '/login'
    end
  end

  patch '/logs/:id' do
    @log = Log.find(params[:id])

    # NEEDS LOGIC
    if 
    	redirect '/logs/#{@log.id}'
    else

      redirect to "/logs/#{@log.id}/edit"
    end
  end

  delete '/logs/:id/delete' do
    @log = Log.find_by_id(params[:id])
    if @log.user == current_user
      Log.delete(params[:id])
      redirect '/logs'
    else
    	# error message - You must Log In!
      redirect '/login'
    end
  end
end