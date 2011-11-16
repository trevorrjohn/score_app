class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:sucess] = "Welcome back, thanks for loging in!"
      @user = user
      redirect_to @user
    else
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:sucess] = "Goodbye!"
    redirect_to root_path
  end

end
