class UsersController < ApplicationController
  before_filter :signed_in_user, except: [:new, :create]
  before_filter :signed_out_user, only: [:new, :create]
  before_filter :check_invitation, only: [:new]

  def index
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

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    if @user.update_attributes(params[:user])
      redirect_to '/users'
    else
      render 'edit'
    end
  end

  private
    def signed_in_user
      redirect_to signin_path unless signed_in?
    end

    def check_invitation
      if (_invite = Invite.find_by_invite(params[:invite])) && _invite.status
        _invite.status = false
        _invite.save
      else
        redirect_to root_path
      end
    end
end