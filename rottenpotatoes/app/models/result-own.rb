require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'movie'

class Result < Array
  def initialize(title)
    url = "http://api.themoviedb.org/2.1/Movie.search/en/xml/0145b2c6108c645e9c19c15368fcf381/" + URI.escape(title)
	doc = Hpricot(open(url))
	@movies = Array.new
	top_five = doc.search("//movie")[0,5]
	top_five.each do |movie|
	  overview = movie.search("overview").inner_html
	  scores = movie.search("score").inner_html
	  rating = movie.search("rating").inner_html
	  released_on = movie.search("released").inner_html
	  name = movie.search("original_name").inner_html
	  @movies << Movie.new(name,overview,scores,rating,released_on)
	end
  end
  
  def [](index)
    @movies[index]
  end
  
  def empty?
    @movies.empty?
  end
  
end