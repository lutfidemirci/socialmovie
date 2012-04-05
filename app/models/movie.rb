class Movie < ActiveRecord::Base
  def self.create_with_tmdb(result)
    create! do |movie|
      movie.title = result["original_title"]
      movie.description = result["overview"].nil? ? "No overview found." : result["overview"]
      movie.poster = result["poster_path"].nil? ? "http://placehold.it/185x276" : TMDB_W185_IMAGE_URL + result["poster_path"]
      movie.tmdb_id = result["id"]
    end
  end
end
