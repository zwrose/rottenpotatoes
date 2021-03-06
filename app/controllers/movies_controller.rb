class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
		#debugger
		if session.include?(:params)
			unless session[:params].eql? params
				params.each_key do |p|
					unless session[:params][p] == params[p]
						session[:params][p] = params[p]
					end
				end
				#debugger
				flash.keep
				redirect_to movies_path(session[:params])
			end
		else
			session[:params] = params
		end
		

		@all_ratings = Movie.pluck(:rating).uniq.sort
		if params[:ratings].blank?
			@checked_ratings = @all_ratings
		else
			@checked_ratings = params[:ratings].keys
		end
		@sort = params[:sort]
		if params[:sort] == 'title'
			@movies = Movie.order('title').find_all_by_rating(@checked_ratings)
		elsif params[:sort] == 'release_date'
			@movies = Movie.order('release_date').find_all_by_rating(@checked_ratings)
		else
			@movies = Movie.find_all_by_rating(@checked_ratings)
		end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
