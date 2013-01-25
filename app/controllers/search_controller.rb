class SearchController < ApplicationController
  def index
  end

  protected
  def searched?
    params[:query].present?
  end
  helper_method :searched?

  def search_results
    if searched?
      @results ||= Search::CombinedService.new(params[:query]).results
    end
  end
  helper_method :search_results
end
