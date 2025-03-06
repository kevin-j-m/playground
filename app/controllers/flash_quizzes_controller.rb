class FlashQuizzesController < ApplicationController
  def index
    flash[:foo] = "bar"
  end

  def show
    if params[:redirect_to_edit] == "and_log"
      _value_to_use = flash[:baz]
      redirect_to edit_flash_quiz_path(params[:id])
    elsif params[:redirect_to_edit].present?
      redirect_to edit_flash_quiz_path(params[:id])
    end
  end

  def edit; end
end

# link_to "Link One", redirecting_path => flash[:foo] = bar
# link_to "Link Two", redirecting_path(my_param: "t") => flash[:foo] = nil


