class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :show]
  before_filter :correct_user, :only => [:edit, :update, :show]
  before_filter :admin_user,   :only => [:destroy, :index]

  def destroy
    User.find(params[:id]).destroy
    flash[:sucess] = "User destroyed."
    redirect_to users_path
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

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

  def edit
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      user = @user
      session[:user_id] = user.id
      sign_in @user
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      puts @user.admin?
      if !current_user?(@user)
        if !current_user.admin?
          flash[:success] = "You are unautharized to view/edit other users."
          redirect_to current_user
        end
      end
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
