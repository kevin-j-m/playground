require "rails_helper"

RSpec.describe "tech support prompts", type: :request do
  describe "GET /show" do
    it "displays the prompts in the proper order" do
      get tech_support_prompt_path

      expect(response.body.split(" - ")).to eq [
        "Thank you for calling technical support.",
        "Call volume is higher than expected.",
        "Press 9 to receive a call back when an agent is available."
      ]
    end
  end
end
