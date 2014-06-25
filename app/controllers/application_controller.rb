class ApplicationController < ActionController::Base
  protect_from_forgery

  after_action ->{ headers['X-Authentication-Token'] = current_user.try(:authentication_token) }, if: "current_user.present?"

  before_filter :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user = user_token && User.find_by_authentication_token(user_token.to_s)

    if user
      sign_in user, store: false
    end
  end

  def handle_unverified_request
    sign_out
    super
  end
end
