class UsersController < ApplicationController
  def index
    #TODO: заменить на кьюрент пользователя
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to '/users'
    else
      render 'new'
    end
  end
end