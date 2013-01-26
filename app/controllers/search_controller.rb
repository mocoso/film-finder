class SearchController < ApplicationController
  def index
  end

  protected
  def searched?
    params[:query].present?
  end
  helper_method :searched?

  def search_results_grouped_by_film
    if searched?
      @results ||= Search::CombinedService.
        new(params[:query]).
        results.
        group_by { |sr| sr.title.downcase }.
        sort_by { |f| f.last.size }.
        reverse
    end
  end
  helper_method :search_results_grouped_by_film
end
