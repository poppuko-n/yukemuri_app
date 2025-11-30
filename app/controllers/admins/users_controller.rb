class Admins::UsersController < Admins::ApplicationController
  before_action :set_user, only: %i[show destroy]
  def index
    @users = User.default_order
  end

  def show; end

  def destroy
    if @user.destroy
      redirect_to admins_users_path, notice: t('controller.destroyed'), status: :see_other
    else
      redirect_to admins_user_path(@user), alert: '予約があるため、このユーザは削除できません。'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
