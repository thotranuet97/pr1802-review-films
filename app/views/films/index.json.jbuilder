json.films @films do |film|
  json.id film.id
  json.title film.name
  json.url film_url(film)
end
