require 'rails_helper'

RSpec.describe 'admin-only slug management' do
  before(:each) do
    @admin = create(:admin)
    @user_1 = create(:user)
    @user_2 = create(:user)
    @merchants = create_list(:merchant, 2)
    @item_1 = create(:item, user: @merchants[0])
    @item_2 = create(:item, user: @merchants[0])
    @item_3 = create(:item, user: @merchants[1])
    @item_4 = create(:item, name: "test1", user: @merchants[1])
    @item_5 = create(:item, name: "test1", user: @merchants[1])
    orders = create_list(:completed_order, 2, user: @user_1)
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

  it 'lists and edits item slugs' do
    visit admin_items_path
    expect(page).to have_link(@item_1.name)
    expect(page).to have_link(@item_2.name)
    expect(page).to have_link(@item_3.name)
    expect(page).to have_link(@item_4.name)
    expect(page).to have_link(@item_5.name)

    within("##{@item_1.slug}") do
      fill_in("item_slug", with: "testslug1")
      click_on("Update Item")
    end

    actual = @item_1.reload.slug
    expected = "testslug1"
    expect(actual).to eq(expected)

  end

  it 'edits user slugs' do
    visit admin_users_path
    expect(page).to have_link(@user_1.name)
    expect(page).to have_link(@user_2.name)
    
    within("##{@user_1.slug}") do
      fill_in("user_slug", with: "testuserslug1")
      click_on("Update User")
    end

    actual = @user_1.reload.slug
    expected = "testuserslug1"
    expect(actual).to eq(expected)

  end
end
