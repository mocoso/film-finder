class ApplicationController < ActionController::Base
  protect_from_forgery

  def hydra
    @hydra ||= Typhoeus::Hydra.new
  end
end
