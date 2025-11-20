class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def redirect_if_logged_in
    if admin_signed_in?
      redirect_to admins_root_path, notice: t('devise.failure.already_authenticated')
    elsif user_signed_in?
      redirect_to users_root_path, notice: t('devise.failure.already_authenticated')
    end
  end
end
