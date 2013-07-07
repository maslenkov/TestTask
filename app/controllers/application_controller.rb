class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper

  def handle_univeified_request
    sign_out
    super
  end

  protected
    def signed_out_user
      redirect_to '/users' if signed_in?
    end
end
