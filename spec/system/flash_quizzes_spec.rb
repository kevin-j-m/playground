require "rails_helper"

RSpec.describe "Flash Quizzes", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "retains the flash value for display when redirecting to the edit page" do
    visit flash_quizzes_path

    click_link "Show this quiz (secret edit)"

    expect(page).to have_content "bar"
    # commit_flash - index action
    #   flash_hash and present
    # commit_flash - show action - flash_hash is nil
    # commit_flash - edit action?
    #   flash_hash and present
    #   session loaded and session key and session flash nil
  end

  it "retains the flash value for display when redirecting to the edit page and logging" do
    visit flash_quizzes_path

    click_link "Show this quiz (secret edit and log)"

    expect(page).to have_content "bar"
    # commit_flash - index action
    #   flash_hash and present
    # commit_flash - show action
    #   flash_hash and present
    #   session loaded and session key and session flash nil
    # commit_flash - edit action?
  end
end
