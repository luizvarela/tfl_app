class DisruptionsController < ApplicationController
  def index
    data = TrafficDisruptions::Fetcher.call
    
    render json: data, status: :ok
  end
end
