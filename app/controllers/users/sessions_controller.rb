class Users::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_authenticity_token, only: :create

  def create
    if request.headers['X-TL-Client'] == 'extension'
      super do |current_user|
        env['rack.session.options'][:skip] = true
        headers['X-TL-Token'] = current_user.authentication_token
        head :created and return
      end
    elsif request.headers['X-TL-Client'] == 'application'
      super
    end
  end

  def destroy
    super
  end
end
