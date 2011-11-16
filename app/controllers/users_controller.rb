class UsersController < ApplicationController
  before_filter :authenticate, :only => [:show]
  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:sucess] = "Welcome, thanks for signing up!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  private

    def authenticate
      deny_access unless signed_in?
    end
end
