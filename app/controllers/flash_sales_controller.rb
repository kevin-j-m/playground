class FlashSalesController < ApplicationController
  def index
    if FlashSale.off?
      if AttemptLogger.log?
        Rails.logger.info "Flash sale accessed when over with cta: #{flash[:sale]}"
        # TODO: use flash.keep to preserve it.
        # flash.keep(:sale)
      end

      redirect_to products_path and return
    end

    @products = [
      donner_red_hss_starter_kit,
      martin_junior_acoustic,
      squier_affinity_strat_junior_hss,
    ]
  end
end
