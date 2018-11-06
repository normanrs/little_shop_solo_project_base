class Admin::UsersController < ApplicationController
  before_action :require_admin

  def update
    @user = User.find_by(slug: params[:id])
    @user.update(admin_params)
    redirect_to admin_users_path
  end

  def index
    @users = User.all
  end

  private

    def admin_params
      params.require(:user).permit(:slug)
    end

    def require_admin
      unless current_user.admin?
        redirect_to root_path
      end
    end

end
