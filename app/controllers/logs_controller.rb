require 'pry'

class LogsController < ApplicationController
  
  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/logs") }
  end

	get '/logs' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      @logs = Log.all
      erb :log_list
    end
  end

  get '/logs/new' do
    if logged_in?
      erb :create_log
    else
      redirect '/login'
    end
  end

  post '/logs' do
    @user = current_user

    # need to make sure that the date and at least one activity is filled out to create a Log

    if params[:date] != ""
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
    	binding.pry
    	redirect '/logs'
    else
    	redirect '/logs/new'
    end
  end

  get '/logs/:id' do
    if logged_in?
      @log = Log.find_by_id(params[:id])
      erb :show_log
    else
      redirect '/login'
    end
  end

  get '/logs/:id/edit' do
    if logged_in?
      @log = Log.find(params[:id])
      erb :edit_log
    else
      redirect '/login'
    end
  end

  patch '/logs/:id' do
    @log = Log.find(params[:id])

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
      redirect '/login'
    end
  end
end