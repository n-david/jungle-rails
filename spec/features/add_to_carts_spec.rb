require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "The cart amount gets updated" do
    # ACT
    visit root_path
    page.find('.actions a.btn-primary', match: :first).click

    # DEBUG
    save_screenshot

    # VERIFY
    puts page
    expect(page).to have_content 'My Cart (1)'
  end
end
