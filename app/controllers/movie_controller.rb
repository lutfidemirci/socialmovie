class MovieController < ApplicationController
  def show
    id = params["id"]
    @movie = detect_movie(id)
    @og_type = "video.movie"
    @og_title = @movie.title
    @og_description = @movie.description.nil? ? "no description" : @movie.description[0..50] + "..."
    @og_url = DOMAIN_URL + "/movie/" + id
    @og_image = @movie.poster
  end
  
  def wantwatch
    id = params["id"]
    movie = detect_movie(id)
    url = URI.parse('https://graph.facebook.com/me/social_movie:want_to_watch')
    req = Net::HTTP::Post.new(url.path)
    args = { 'access_token' => current_user.facebook_token, 'movie' => DOMAIN_URL + "/movie/" + id }
    req.set_form_data(args)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    all_response = http.request(req)
    response = all_response.body
    if response["error"]
      json_response = { "status" => "false", "error" => response }
    else
      action = Action.create(:user => current_user, :movie => movie, :name => "wantwatch", :fbid => response["id"])
      json_response = { "status" => "true", "action_id" => action.id }
    end
    render :json => json_response
  end
  
  def listwatch
    id = params["id"]
    movie = detect_movie(id)
    url = URI.parse('https://graph.facebook.com/me/social_movie:list_as_watched')
    req = Net::HTTP::Post.new(url.path)
    args = { 'access_token' => current_user.facebook_token, 'movie' => DOMAIN_URL + "/movie/" + id }
    req.set_form_data(args)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    all_response = http.request(req)
    response = all_response.body
    if response["error"]
      json_response = { "status" => "false", "error" => response }
    else
      action = Action.create(:user => current_user, :movie => movie, :name => "watch", :fbid => response["id"])
      json_response = { "status" => "true", "action_id" => action.id }
    end
    render :json => json_response
  end
  
  def search
    @query = URI.escape(params["query"], Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    @current_page = params["page"] || 1 
    @current_page = @current_page.to_i
    url = "http://api.themoviedb.org/3/search/movie?query=#{@query}&api_key=#{TMDB_API_KEY}&page=#{@current_page}&include_adult=true"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body
    result = JSON.parse(data)
    @movies = result["results"]
    @result_count = result["total_results"]
    @total_pages = result["total_pages"]
    @pages = pagination(@current_page, @total_pages)
  end
  
  private
  def detect_movie(id)
    unless movie = Movie.find_by_tmdb_id(id)
      url = "http://api.themoviedb.org/3/movie/#{id}?api_key=#{TMDB_API_KEY}"
      resp = Net::HTTP.get_response(URI.parse(url))
      data = resp.body
      result = JSON.parse(data)
      movie = Movie.create_with_tmdb(result) 
    end
    return movie
  end
  
  def pagination(i, total)
    pages = []
    pages << i-3 if i-3 > 0
    pages << i-2 if i-2 > 0
    pages << i-1 if i-1 > 0
    pages << i
    pages << i+1 if i+1 <= total
    pages << i+2 if i+2 <= total
    pages << i+3 if i+3 <= total
    return pages
  end
  
end
