require 'spec_helper'

describe MoviesController do
  before(:each) do
    class Array
	  def save(movie)
		self << movie
      end
	end
    @fakedb = []
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
   @fakedb << @movie1
   @fakedb << @movie2
   @fakedb << @movie3
   @fakedb << @movie4
   @fakedb << @movie5
  end
  
	
  def mock_movie(stubs={})
    @mock_movie ||= mock_model(Movie, stubs)
  end	
  
  
  #do we need to mimick how the user clicks the save button
  
  describe "Data is correct" do
    it "should check to see the right values were assigned to the right fields" do
	  abc = @fakedb[0]
	  abc.should == @movie1
	  
	  
	  
	end
	
	it "should return 5 movies from data structure" do
	  
	  listOfMovies.size.should == 5
	  
	  assigns[:results].should == @fakedb
	end
  end
  
  
  
  describe "GET index" do
    it "assigns all movies as @movies" do
      Movie.stub(:find).with(:all).and_return([mock_movie])
      get :index
      assigns[:movies].should == [mock_movie]
    end
  end

  describe "GET show" do
    it "assigns the requested movie as @movie" do
      Movie.stub(:find).with("37").and_return(mock_movie)
      get :show, :id => "37"
      assigns[:movie].should equal(mock_movie)
    end
  end

  describe "GET new" do
    it "assigns a new movie as @movie" do
      Movie.stub(:new).and_return(mock_movie)
      get :new
      assigns[:movie].should equal(mock_movie)
    end
  end

  describe "GET edit" do
    it "assigns the requested movie as @movie" do
      Movie.stub(:find).with("37").and_return(mock_movie)
      get :edit, :id => "37"
      assigns[:movie].should equal(mock_movie)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created movie as @movie" do
        Movie.stub(:new).with({'these' => 'params'}).and_return(mock_movie(:save => true))
        post :create, :movie => {:these => 'params'}
        assigns[:movie].should equal(mock_movie)
      end

      it "redirects to the created movie" do
        Movie.stub(:new).and_return(mock_movie(:save => true))
        post :create, :movie => {}
        response.should redirect_to(movie_url(mock_movie))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved movie as @movie" do
        Movie.stub(:new).with({'these' => 'params'}).and_return(mock_movie(:save => false))
        post :create, :movie => {:these => 'params'}
        assigns[:movie].should equal(mock_movie)
      end

      it "re-renders the 'new' template" do
        Movie.stub(:new).and_return(mock_movie(:save => false))
        post :create, :movie => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested movie" do
        Movie.should_receive(:find).with("37").and_return(mock_movie)
        mock_movie.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :movie => {:these => 'params'}
      end

      it "assigns the requested movie as @movie" do
        Movie.stub(:find).and_return(mock_movie(:update_attributes => true))
        put :update, :id => "1"
        assigns[:movie].should equal(mock_movie)
      end

      it "redirects to the movie" do
        Movie.stub(:find).and_return(mock_movie(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(movie_url(mock_movie))
      end
    end

    describe "with invalid params" do
      it "updates the requested movie" do
        Movie.should_receive(:find).with("37").and_return(mock_movie)
        mock_movie.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :movie => {:these => 'params'}
      end

      it "assigns the movie as @movie" do
        Movie.stub(:find).and_return(mock_movie(:update_attributes => false))
        put :update, :id => "1"
        assigns[:movie].should equal(mock_movie)
      end

      it "re-renders the 'edit' template" do
        Movie.stub(:find).and_return(mock_movie(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested movie" do
      Movie.should_receive(:find).with("37").and_return(mock_movie)
      mock_movie.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the movies list" do
      Movie.stub(:find).and_return(mock_movie(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(movies_url)
    end
  end

end
