class Admin::InvitesController < ApplicationController
  def index
    @invites = last_10_invites
  end

  def create
    if permitted_params[:email] =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      new_invite = Invite.new
      new_invite.save
      InviteMailer.invitation_email(permitted_params[:email], new_invite.invite).deliver
    else
      @errors = ['Invalid email']
    end
    @invites = last_10_invites
    render 'index'
  end

  private
    def last_10_invites
      Invite.order('created_at desc').limit 10
    end

    def permitted_params
      params.require(:sender).permit(:email)
    end
end
