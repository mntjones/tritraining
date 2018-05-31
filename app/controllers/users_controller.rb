class UsersController < ApplicationController
   
   configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/users") }
    enable :sessions
    set :session_secret, "secret"
  end

	get '/' do
    erb :welcome
  end

  get '/signup' do
    if logged_in?
      redirect '/logs'
    else
      erb :create_user
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password], email: params[:email])
    if @user.save
      session[:user_id] = @user.id
      redirect '/logs'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/logs'
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/logs'
    else
      redirect '/'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect '/'
    end
  end

end