class FlashQuizzesController < ApplicationController
  def index
    flash[:foo] = "bar"
  end

  def show
    if params[:redirect_to_edit] == "and_log"
      # binding.irb
      _value_to_use = flash[:baz]
      # binding.irb
      redirect_to edit_flash_quiz_path(params[:id])
    elsif params[:redirect_to_edit].present?
      # binding.irb
      redirect_to edit_flash_quiz_path(params[:id])
    end
  end

  def edit
    # binding.irb
  end
end

# link_to "Link One", redirecting_path => flash[:foo] = bar
# link_to "Link Two", redirecting_path(my_param: "t") => flash[:foo] = nil


