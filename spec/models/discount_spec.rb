require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'Relationships' do
    it { should belong_to(:item) }
  end

  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, user: @merchant)
    @discount_1 = Discount.create!( :range_low => 10,
                                    :range_high => 20,
                                    :percent => 4.5,
                                    :item => @item_1)

    @discount_2 = Discount.create!( :range_low => 20,
                                    :range_high => 20,
                                    :percent => 9.5,
                                    :item => @item_1)

  end



end
