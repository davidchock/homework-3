require 'spec_helper'

describe Movie do
 before(:each) do
   @valid_attributes = {
     :title => "Pocahontas",
     :description => "A movie about the new world.",
     :rating => "G",
     :released_on => Time.parse("1/1/1995")
   }
 end
 it "should create a new instance given valid attributes" do
   Movie.create(@valid_attributes).should be_true
 end

 

 describe "when validating a movie" do
   it "should not allow a movie with no title" do
     @no_title_attributes = {
       :description => "A movie about the new world.",
       :rating => "G",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@no_title_attributes)
     @movie.should_not be_valid
   end
   it "should not allow a movie with no description" do

     @no_description_attributes = {
       :title => "Avatar",
       :rating => "PG-13",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@no_description_attributes)
     @movie.should_not be_valid

   end
	 
   it "should not allow a movie with a title that is not unique" do
	 Movie.create(@valid_attributes)
		@movie = Movie.new(@valid_attributes)
		@movie.should_not be_valid
	 end
	 it "should not allow a movie with a description less than 10 characters long" do
	   @movie_attributes = {
       :title => "Avatar",
			 :description => "too short",
       :rating => "PG-13",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@movie_attributes)
     @movie.should_not be_valid
	 end
   it "should allow a movie with a valid movie rating" do
		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "PG-13",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@valid_rating_attributes)
     @movie.should be_valid
	 end
	
   it "should not allow a movie with an invalid movie rating" do
	 	@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "PG-14",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@valid_rating_attributes)
     @movie.should_not be_valid
		end
 end

 

 # Add more specs here!

 


 describe "when checking age-appropriateness" do
   it "should be appropriate for a 15-year-old if rated G" do
		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "G",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@valid_rating_attributes)
		 @movie.appropriate_for_birthdate?(15.year.ago).should == true 
	end
	it "should be appropriate for a 15-year-old if rated PG" do
		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "PG",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@valid_rating_attributes)
		 @movie.appropriate_for_birthdate?(15.year.ago).should == true 
	end
	it "should be appropriate for a 13-year-old if rated PG-13" do
		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "PG-13",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@valid_rating_attributes)
		 @movie.appropriate_for_birthdate?(13.year.ago).should == true 
	end
	it "should be appropriate for a 17-year-old if rated R" do
		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "R",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@valid_rating_attributes)
		 @movie.appropriate_for_birthdate?(17.year.ago).should == true 
	end
	it "should be appropriate for a 17-year-old if rated NC-17" do
		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "NC-17",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@valid_rating_attributes)
		 @movie.appropriate_for_birthdate?(17.year.ago).should == true 
	end
   it "should be appropriate for a 30-year-old if rated G" do
	 		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "G",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@valid_rating_attributes)
		 @movie.appropriate_for_birthdate?(30.year.ago).should == true 
		 end

   it "should not be appropriate for a 15-year-old if rated R" do
	 		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "R",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@valid_rating_attributes)
		 @movie.appropriate_for_birthdate?(15.year.ago).should == false 
	end
	it "should not be appropriate for a 15-year-old if rated NC-17" do
	 		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "NC-17",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@valid_rating_attributes)
		 @movie.appropriate_for_birthdate?(15.year.ago).should == false 
	end
	it "should not be appropriate for a 12-year-old if rated PG-13" do
	 		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "PG-13",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@valid_rating_attributes)
		 @movie.appropriate_for_birthdate?(12.year.ago).should == false 
	end
 end

 describe "database finder for age-appropriateness" do
   it "should always include G rated movies" do
     @movie = Movie.create(@valid_attributes)
     Movie.find_all_appropriate_for_birthdate(Time.now).should include(@movie)
   end

   it "should exclude R rated movies if age is less than 17" do
		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "R",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.create(@valid_rating_attributes)
		 Movie.find_all_appropriate_for_birthdate(16.year.ago).should_not include(@movie)
	end
	it "should exclude R rated movies if age is less than 17" do
		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "R",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.create(@valid_rating_attributes)
		 Movie.find_all_appropriate_for_birthdate(16.year.ago).should_not include(@movie)
	end
	it "should exclude PG-13 rated movies if age is less than 13" do
		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "PG-13",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.create(@valid_rating_attributes)
		 Movie.find_all_appropriate_for_birthdate(12.year.ago).should_not include(@movie)
	end
	it "should exclude R rated movies if age is less than 17" do
		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "R",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.create(@valid_rating_attributes)
		 Movie.find_all_appropriate_for_birthdate(16.year.ago).should_not include(@movie)
	end
	it "should exclude NC-17 rated movies if age is less than 17" do
		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "NC-17",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.create(@valid_rating_attributes)
		 Movie.find_all_appropriate_for_birthdate(16.year.ago).should_not include(@movie)
	end
	it "should exclude PG-13,R,and NC-17 rated movies if age is less than 13" do
		@valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "PG-13",
       :released_on => Time.parse("1/1/1995")
     }
		 @valid_rating_attributes2 = {
       :title => "Avatar2",
			 :description => "too short to care",
       :rating => "R",
       :released_on => Time.parse("1/1/1995")
     }
		 @valid_rating_attributes3 = {
       :title => "Avatar3",
			 :description => "too short to care",
       :rating => "NC-17",
       :released_on => Time.parse("1/1/1995")
     }
		 @valid_rating_attributes4 = {
       :title => "Avatar4",
			 :description => "too short to care",
       :rating => "G",
       :released_on => Time.parse("1/1/1995")
     }
		 @valid_rating_attributes5 = {
       :title => "Avatar5",
			 :description => "too short to care",
       :rating => "PG",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.new(@valid_rating_attributes)
		 @movie1 = Movie.create(@valid_rating_attributes2)
		 @movie2 = Movie.create(@valid_rating_attributes3)
		 @movie3 = Movie.create(@valid_rating_attributes4)
		 @movie4 = Movie.create(@valid_rating_attributes5)
		 Movie.find_all_appropriate_for_birthdate(12.year.ago).should_not include(@movie,@movie1,@movie2)
	end
	it "should include PG-13,NC-17,R,G,PG rated movies if age is greater than 16" do
		 @valid_rating_attributes = {
       :title => "Avatar",
			 :description => "too short to care",
       :rating => "R",
       :released_on => Time.parse("1/1/1995")
     }
     @movie = Movie.create(@valid_rating_attributes)
		 Movie.find_all_appropriate_for_birthdate(17.year.ago).should include(@movie)
	end
 end
end