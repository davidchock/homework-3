class Movie < ActiveRecord::Base
	validates_presence_of :title
	validates_uniqueness_of :title 
	#validates_presence_of :description
	#validates_length_of :description, :minimum => 10
	#validates_inclusion_of :rating, :in => %w(G PG PG-13 R NC-17)
	attr_accessor :rating
	attr_accessor :overview
	attr_accessor :genre
	attr_accessor :scores
	attr_accessor :released_on
	
	def appropriate_for_birthdate?(birthdate)
		if self.rating == "R" or self.rating == "NC-17"
			return birthdate <= 17.years.ago
		elsif self.rating == "PG-13"
			return birthdate <= 13.years.ago
		else
			return true
		end
	end
	
	def self.find_all_appropriate_for_birthdate(birthdate)
		if birthdate <= 17.years.ago
			ret = Movie.find(:all)
		elsif birthdate <= 13.years.ago
			ret = Movie.find(:all, :conditions => {:rating => ["PG", "G", "PG-13"]} )			
		else Movie.find(:all, :conditions => {:rating => ["PG", "G"]})
		end
	end
end
