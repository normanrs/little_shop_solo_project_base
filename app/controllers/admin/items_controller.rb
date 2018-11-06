class Admin::ItemsController < ApplicationController
  before_action :require_admin

  def update
    @item = Item.find_by(slug: params[:id])
    @item.update(admin_params)
  end

  def index
    @items = Item.all
  end

private

  def admin_params
    params.require(:item).permit(:slug)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

end
