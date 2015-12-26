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
      film_query.films
    end
  end
  helper_method :films

  def unavailable_sources
    if searched?
      film_query.unavailable_sources
    end
  end
  helper_method :unavailable_sources

  def film_query
    if searched?
      @film_query ||= FilmQuery.new(params[:query])
    end
  end
end
