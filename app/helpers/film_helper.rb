module FilmHelper
  def film_meta_data(film)
    meta_data = []
    meta_data << 'TV Episode' if film.type == Rental::TV_EPISODE_TYPE
    meta_data << film.year if film.year.present?
    meta_data << "Cert: #{film.certificate}" if film.certificate.present?
    meta_data
  end
end
