require "rails_helper"

RSpec.describe "flash quizzes", type: :request do
  describe "GET /index" do
    it "stores a value in flash" do
      get flash_quizzes_path

      expect(response).to be_successful
      expect(flash[:foo]).to eq :bar
    end
  end

  describe "GET /show" do

  end

  describe "GET /edit" do

  end
end
