class StreamChangesController < ApplicationController
  def create
    text = params[:text]

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "stream_target",
          partial: "stream_changes/result",
          locals: { input: text }
        )
      end
    end
  end
end
