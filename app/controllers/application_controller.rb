class ApplicationController < ActionController::Base
  protect_from_forgery

  after_action ->{ headers['X-Authentication-Token'] = current_user.try(:authentication_token) }, if: "current_user.present?"

  def handle_unverified_request
    sign_out
    super
  end
end
