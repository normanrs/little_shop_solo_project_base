class DiscountsController < ApplicationController
  def index
    @discounts = Discount.all
  end

  def show
  end

  def new
    @discount = Discount.new
  end

  def edit
  end

  def create
    @discount = Discount.new(discount_params)
  end

  def update
  end

  def destroy
    @discount.destroy
    respond_to do |format|
      format.html { redirect_to discounts_url, notice: 'Discount was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_discount
      @discount = Discount.find(params[:id])
    end

    def discount_params
      params.require(:discount).permit(:range_low, :range_high, :percent, :item_id)
    end
end
