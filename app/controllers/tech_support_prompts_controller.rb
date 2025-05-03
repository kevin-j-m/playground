class TechSupportPromptsController < ApplicationController
  include Callbackable

  before_action :set_prompts
  before_action :add_callback_notices

  def show
    render inline: "<%= @prompts.join(' - ') %>"
  end

  private

  def set_prompts
    @prompts = []
    @prompts << "Thank you for calling technical support."
  end
end
