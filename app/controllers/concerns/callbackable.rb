module Callbackable
  extend ActiveSupport::Concern

  private

  def add_callback_notices
    @prompts << "Call volume is higher than expected."
    @prompts << "Press 9 to receive a call back when an agent is available."
  end
end
