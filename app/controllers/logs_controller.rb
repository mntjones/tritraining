require 'pry'
require 'rack-flash'
require 'date'

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
      @logs = []
      # Go through all the logs and move only the logs that belong to the user into the variable: @logs
      Log.all.each do |log|
      	if log.user.username == @user.username
      		@logs << log
      	end
      end

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
    # checking if the date is NOT empty and the Date is in a datetime format
    if params[:date] != "" && !Date._parse(params[:date]).empty?
    	# checking if all activities are blank - if so, an error message and redirect to new form.
    	if params[:swim_distance] == "" && params[:bike_distance] == "" && params[:run_distance] == ""
    		flash[:message] = "Please enter at least 1 activity distance to save."
    		redirect 'logs/new'
    	end
    	# if there is a date and at least one activity recorded, a new log is created. It checks each activity and either
    	# saves the entered number or a zero, if blank.
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
    	# if no date, error message and redirect
    	flash[:message] = "Please enter a date (YYYY/MM/DD)"
    	redirect '/logs/new'
    end
  end

  get '/logs/:id' do
  	#@user = current_user
  	@log = Log.find_by(id: params[:id])
    if logged_in? && current_user.username == @log.user.username
      #checks if current user is logged in and the user matches the log's user
      
      erb :'/logs/show_log'
    elsif !logged_in?
    	flash[:message] = "You must Log In!"
    	# error message - You must Log In!
      redirect '/login'
    else
    	flash[:message] = "This log is not yours!"
    	# error message - Not your log
      redirect '/logs'
    end
  end

  get '/logs/:id/edit' do
  	# check if user is logged in. If so, renders edit page. If not, error message flashes and user redirected to log in.

		@log = Log.find_by(id: params[:id])
    if logged_in? && current_user.username == @log.user.username
      erb :'/logs/edit_log'
    else
    	flash[:message] = "You must Log In!"
      redirect '/login'
    end
  end

  patch '/logs/:id' do
    @log = Log.find_by(id: params[:id])

    if params[:date] != "" && !Date._parse(params[:date]).empty?
    	@log.date = params[:date]

    	if params[:swim_distance] == "" && params[:bike_distance] == "" && params[:run_distance] == ""
    		flash[:message] = "Please enter at least 1 activity distance to save."
    		redirect to "logs/#{@log.id}/edit"
    	end

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

    	redirect to "/logs/#{@log.id}"
    else
    	flash[:message] = "Enter date to Update"
      redirect to "/logs/#{@log.id}/edit"
    end
  end

  delete '/logs/:id/delete' do
    @log = Log.find_by(id: params[:id])
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