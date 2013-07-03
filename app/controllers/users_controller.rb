class UsersController < ApplicationController
  def index
    @user = User.first
  end

  def new
    @user = User.new
  end
end