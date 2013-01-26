class SearchController < ApplicationController
  def index
  end

  protected
  def searched?
    params[:query].present?
  end
  helper_method :searched?

  def films
    if searched?
      @films ||= FilmQuery.new(params[:query]).films
    end
  end
  helper_method :films
end
