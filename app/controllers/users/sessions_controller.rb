class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    if request.headers['X-TL-Client'] == 'extension'
      super do |current_user|
        env['rack.session.options'][:skip] = true
        headers['X-TL-Token'] = current_user.extension_token
        head :created and return
      end
    elsif request.headers['X-TL-Client'] == 'application'
      super do
        add_csrf_to_headers
      end
    end
  end

  def destroy
    super do
      add_csrf_to_headers
    end
  end
end
