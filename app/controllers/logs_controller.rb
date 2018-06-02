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