class FlashQuizzesController < ApplicationController
  def index
    flash[:foo] = :bar
  end

  def show
    if params[:my_param] == "t"
      _value_to_use = flash[:baz]
      redirect_to edit_flash_quizzes_path
    end
  end

  def edit; end
end

# link_to "Link One", redirecting_path => flash[:foo] = bar
# link_to "Link Two", redirecting_path(my_param: "t") => flash[:foo] = nil


