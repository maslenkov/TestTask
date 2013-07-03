class UsersController < ApplicationController
  def index
    @user = User.first
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.sav
      #TODO: проверить тест, затем раскоментить сию строку
    # redirect_to '/users'
    else
      render 'new'
    end
  end
end