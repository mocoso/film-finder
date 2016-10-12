class SearchController < ApplicationController
  def index
  end

  def search
    if params[:query].blank?
      redirect_to '/'
    end
  end

  protected
  def films
    film_query.films
  end
  helper_method :films

  def unavailable_sources
    film_query.unavailable_sources
  end
  helper_method :unavailable_sources

  def film_query
    @film_query ||= FilmQuery.new(params[:query])
  end
end
