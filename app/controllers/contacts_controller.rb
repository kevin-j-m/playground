class ContactsController < ApplicationController
  def index
    if FlashSale.on?
      flash[:sale] = "As thanks to you for looking to contact us"
    end
  end
end
