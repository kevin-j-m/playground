require "rails_helper"

RSpec.describe "Flash Sale", type: :system do
  before { driven_by(:rack_test) }

  it "redirects to the products page with the flash message when the flash sale has ended" do
    allow(FlashSale).to receive(:on?).and_return(true)
    visit contacts_path

    allow(FlashSale).to receive(:off?).and_return(true)
    click_link "View Deals"

    expect(page).to have_selector "h1", text: "All Products"
    expect(page).to have_content "As thanks to you for looking to contact us"
  end

  it "logs the flash message when the flash sale has ended and the log sampler wants the message" do
    allow(FlashSale).to receive(:on?).and_return(true)
    visit contacts_path

    allow(FlashSale).to receive(:off?).and_return(true)
    allow(AttemptLogger).to receive(:log?).and_return(true)
    click_link "View Deals"

    expect(page).to have_selector "h1", text: "All Products"
    expect(page).to have_content "As thanks to you for looking to contact us"
  end
end
