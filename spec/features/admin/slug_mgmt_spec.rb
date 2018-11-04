require 'rails_helper'

RSpec.describe 'admin-only slug management' do
  before(:each) do
    @admin = create(:admin)
    @user = create(:user)
    @merchants = create_list(:merchant, 2)
    @item_1 = create(:item, user: @merchants[0])
    @item_2 = create(:item, user: @merchants[0])
    @item_3 = create(:item, user: @merchants[1])
    @item_4 = create(:item, name: "test1", user: @merchants[1])
    @item_5 = create(:item, name: "test1", user: @merchants[1])
    orders = create_list(:completed_order, 2, user: @user)
    create(:fulfilled_order_item, quantity: 10, item: @item_1, order: orders[0])
    create(:fulfilled_order_item, quantity: 20, item: @item_2, order: orders[0])
    create(:fulfilled_order_item, quantity: 40, item: @item_3, order: orders[1])
    create(:fulfilled_order_item, quantity: 30, item: @item_4, order: orders[1])
    create(:fulfilled_order_item, quantity: 20, item: @item_5, order: orders[1])

    visit login_path
    fill_in :email, with: @admin.email
    fill_in :password, with: @admin.password
    click_button 'Log in'

  end

  it 'edits item slugs' do
    visit admin_items_path

  end

  it 'edits user slugs' do
    visit admin_users_path


  end
end
