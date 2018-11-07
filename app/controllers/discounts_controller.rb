class DiscountsController < ApplicationController
  def index
    @discounts = Discount.all
  end

  def show
  end

  def new
    @discount = Discount.new
    @merchant = User.find_by(slug: params[:merchant_slug])
  end

  def edit
  end

  def create
    @merchant = User.find_by(slug: params[:merchant_slug])
    @discount = Discount.new(discount_params)
    @discount.save
  end

  def update
  end

  def destroy
    @discount.destroy
  end

  private
    def set_discount
      @discount = Discount.find(params[:id])
    end

    def discount_params
      params.require(:discount).permit(:range_low, :range_high, :percent, :item_id)
    end
end
