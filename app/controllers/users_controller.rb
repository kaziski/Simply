class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :redirect_unless_admin, only: [:new, :create, :edit]

  def index
    @users = User.all
  end

  def edit
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      redirect_to new_user_registration_path
    end
  end 

  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    @user.update(user_params)
    redirect_to users_path
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :role, :password)
  end

  def redirect_unless_admin
    unless current_user && current_user.role == 'admin'
      flash[:error] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end

end