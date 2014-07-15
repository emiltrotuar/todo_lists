class ApplicationController < ActionController::Base
  protect_from_forgery

  def add_csrf_to_headers
    headers['X-CSRF-Token'] = form_authenticity_token
  end

  def handle_unverified_request
    sign_out
    super
  end
end
