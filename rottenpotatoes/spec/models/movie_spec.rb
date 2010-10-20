require 'spec_helper'

describe Movie do
  before(:each) do
    @fakedb = []
    @movie_list = []

	class Array
	  def save(movie)
		self << movie
      end
	end
    @movie1 = mock_movie({
		:title => "Pocahontas",
		:overview => "No overview found",
		:genre => "Action",
		:scores => "10",
		:rating => "G",
		:released_on => Time.parse("1/1/1995")
		})
	@movie2 = mock_movie({
		:title => "Pocahontas2",
		:overview => "No overview found",
		:genre => "Action",
		:scores => "10",
		:rating => "G",
		:released_on => Time.parse("1/2/1995")
		})
	@movie3 = mock_movie({
		:title => "Pocahontas3",
		:overview => "No overview found",
		:genre => "Action",
		:scores => "10",
		:rating => "G",
		:released_on => Time.parse("1/3/1995")
		})
	@movie4 = mock_movie({
		:title => "Pocahontas4",
		:overview => "No overview found",
		:genre => "Action",
		:scores => "10",
		:rating => "G",
		:released_on => Time.parse("1/4/1995")
		})
	@movie5 = mock_movie({
		:title => "Pocahontas5",
		:overview => "No overview found",
	 :genre => "Action",
     :scores => "10",
     :rating => "G",
     :released_on => Time.parse("1/5/1995")
    })
	
	@movie_list << @movie1
	@movie_list << @movie2
	@movie_list << @movie3
	@movie_list << @movie4
	@movie_list << @movie5

  end
 
   def mock_movie(stubs={})
    @mock_movie ||= mock_model(Movie, stubs)
  end	
 
 describe "(stubbed) tmdb api calls" do 
   it "(stubbed) returns 5 movies when call api " do
     mock_tmdb = mock('Tmdb')
	 Result.stub!(:api_call).and_return(@movie_list)
	 
	 result = Result.api_call("hey")
	 
	 result.size.should == 5
	 result.each do |movie| 
	    movie.class.to_s.should == "Movie"
		
	   end
	 
	end
	
	it "(stubbed) returns 0 movies" do
	  Result.stub!(:api_call).and_return([])
	  
	  result = Result.api_call("")
	  
	  result.size.should == 0
	end
	
	it "(stubbed) should save movie in database" do
	  Result.stub!(:api_call).and_return(@movie_list)
	  result = Result.api_call("Saw")
	  
	  @fakedb.save(result[0])
	  
	  @fakedb.size.should == 1
	  @fakedb[0].should == @movie1
    end
  
  end
 
  describe "non-stubbed tmdb api calls"
    it "returns 5 movies when call api " do
 
	 result = Result.api_call("Finding Nemo")
	 
	 puts results
	 
	 result.size.should == 5
	 result.each do |movie| 
	    movie.class.to_s.should == "Movie"
		
	   end
	 
	end
	
	it "returns 0 movies" do	  
	  result = Result.api_call("")	  
	  result.size.should == 0
	end
	
	it "should save movie in database" do
	  result = Result.api_call("Saw")	  
	  Movie.save(result[0])	  
	  Movie.find(result[0]).should == True
  end
 
 
end