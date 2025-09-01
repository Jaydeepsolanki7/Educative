class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def authorize_first_user_for_create(record_class)
    record = record_class.new
    authorize record, :create?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :role] )
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :role ])
  end

  private

  def user_not_authorized(_exception)
    flash[:alert] = "You are not authorized to perform this action."
    respond_to do |format|
      format.html { redirect_to(request.referer || root_path) }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "flash",
          partial: "layouts/flash"
        )
      end
    end
  end
end
