class FlashQuizzesController < ApplicationController
  def index
    flash[:foo] = "bar"
  end

  def show
    # this gets hit before commit_flash
    if params[:redirect_to_edit] == "secret_password"
      # ActionDispatch::Flash::RequestMethods#flash never gets called.
      # That means flash= never gets called.
      # That means the header never gets set.
      # That means calling flash_hash has no value, because it pulls it from the
      # non-existent header.
      # As a result in commit_flash, the session isn't loaded (because we never
      # used the flash, so the flash method never accessed flash from the
      # session), so it does NOT delete the flash.
      redirect_to edit_flash_quiz_path(params[:id])
    elsif params[:redirect_to_edit].present?
      binding.irb
      Rails.logger.info("accessed edit page with #{params[:redirect_to_edit]} while flash is #{flash[:foo]}")
      # Here we have the call to flash
      # That loads the session by accessing session["flash"]
      # Because ActionDispatch::Request::Session def [](key) calls load_for_read!
      # That calls load! with sets @loaded to true
      #
      # Now in commit_flash, the session is loaded. There is a key for the
      # session. But the session flash is nil. Because in the prior if block, we
      # call session["flash"] = flash_hash.to_session_value.
      #
      # That value is nil, because the flash keys are in the discard. So there
      # are no flashes to keep
      # 
      # binding.irb
      # Below passes because doesn't access flash
      # Rails.logger.info("accessed edit page with #{params[:redirect_to_edit]}")
      redirect_to edit_flash_quiz_path(params[:id])
    end
  end

  def edit
    # binding.irb
  end
end

# link_to "Link One", redirecting_path => flash[:foo] = bar
# link_to "Link Two", redirecting_path(my_param: "t") => flash[:foo] = nil


