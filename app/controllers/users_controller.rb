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
    @user = User.new(permitted_params)
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
    permitted_params.delete(:password) if permitted_params[:password].blank?
    permitted_params.delete(:password_confirmation) if permitted_params[:password_confirmation].blank?
    if @user.update_attributes(permitted_params)
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

    def permitted_params
      params.require(:user).permit(:email, :name, :phone, :password, :password_confirmation)
    end
end
