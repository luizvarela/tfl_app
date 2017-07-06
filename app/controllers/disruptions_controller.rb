class DisruptionsController < ApplicationController
  def index
    data = DisruptionsParser.process
    render json: data, status: :ok
  end
end
