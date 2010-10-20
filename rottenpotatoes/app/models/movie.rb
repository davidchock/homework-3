require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'uri'
    
class Movie < ActiveRecord::Base
	validates_presence_of :title
	validates_uniqueness_of :title 
	#validates_presence_of :description
	#validates_length_of :description, :minimum => 10
	#validates_inclusion_of :rating, :in => %w(G PG PG-13 R NC-17)
	attr_accessor :title
	attr_accessor :rating
	attr_accessor :overview
	attr_accessor :scores
	attr_accessor :released_on
	def initialize(title,overview,scores,rating,released_on)
		@title		=	title
		@overview	=	overview
		@scores		=	scores
		@released_on= released_on
		@rating 	= rating
	end
  def self.look_up(title)
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
	
	
end

