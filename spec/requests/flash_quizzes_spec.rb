require "rails_helper"

RSpec.describe "flash quizzes", type: :request do
  describe "GET /index" do
    it "stores a value in flash" do
      get flash_quizzes_path

      expect(response).to be_successful
      expect(flash[:foo]).to eq "bar"
    end
  end

  describe "GET /show" do
    it "is successful" do
      get flash_quiz_path(1)

      expect(response).to be_successful
    end

    it "redirects to the edit page when flashing the secret parameter" do
      get flash_quiz_path(1, redirect_to_edit: "t")

      expect(response).to redirect_to edit_flash_quiz_path(1)
    end

    # TODO: does this fail under  rails (7.1.5.1)?
    it "retains the flash value when redirecting and logging" do
      get flash_quizzes_path
      expect(flash[:foo]).to eq "bar"

      get flash_quiz_path(1, redirect_to_edit: "and_log")
      expect(flash[:foo]).to eq "bar"
    end

    it "retains the flash value when redirecting and not logging" do
      get flash_quizzes_path
      expect(flash[:foo]).to eq "bar"

      get flash_quiz_path(1, redirect_to_edit: "r")
      expect(flash[:foo]).to eq "bar"
    end
  end

  describe "GET /edit" do

  end
end
