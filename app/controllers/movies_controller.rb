class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sort_column = params[:sort_column]
    @title_header_class = ""
    @release_date_header = "release_date_header"
    @title_header = "title_header"
    @release_date_header_class = ""
    @title = "title"
    @release = "release"
    if @sort_column == "title"
      @title_header_class = "hilite"
      @movies = Movie.order(:title)
    elsif @sort_column == "release"
      @release_date_header_class = "hilite"
      @movies = Movie.order(:release_date)
    else
    @movies = Movie.all
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
