class BackdoorController < ApplicationController
  # To authenticate the backdoor controller, you can uncomment the line below
  # and set the `.env` environment variables ADMIN_USERNAME and ADMIN_PASSWORD.

  # http_basic_authenticate_with name: ENV.fetch("ADMIN_USERNAME"), password: ENV.fetch("ADMIN_PASSWORD")

  def index
    # Main backdoor page with create forms
    render({ :template => "backdoor_templates/backdoor_index" })
  end

  # CREATE ACTIONS
  def create_director
    the_director = Director.new
    the_director.first_name = params.fetch("query_first_name")
    the_director.last_name = params.fetch("query_last_name")
    the_director.dob = params.fetch("query_dob")
    the_director.bio = params.fetch("query_bio")
    the_director.image = params.fetch("query_image")

    if the_director.valid?
      the_director.save
      redirect_to("/backdoor", { :notice => "Director created successfully." })
    else
      redirect_to("/backdoor", { :alert => the_director.errors.full_messages.to_sentence })
    end
  end

  def create_actor
    the_actor = Actor.new
    the_actor.first_name = params.fetch("query_first_name")
    the_actor.last_name = params.fetch("query_last_name")
    the_actor.dob = params.fetch("query_dob")
    the_actor.bio = params.fetch("query_bio")
    the_actor.image = params.fetch("query_image")

    if the_actor.valid?
      the_actor.save
      redirect_to("/backdoor", { :notice => "Actor created successfully." })
    else
      redirect_to("/backdoor", { :alert => the_actor.errors.full_messages.to_sentence })
    end
  end

  def create_movie
    the_movie = Movie.new
    the_movie.title = params.fetch("query_title")
    the_movie.year = params.fetch("query_year")
    the_movie.duration = params.fetch("query_duration")
    the_movie.description = params.fetch("query_description")
    the_movie.image = params.fetch("query_image")
    the_movie.director_id = params.fetch("query_director_id")
    the_movie.released_on = params.fetch("query_released_on", nil)
    the_movie.oscar_cohort = params.fetch("query_oscar_cohort", nil)
    the_movie.result = params.fetch("query_result")

    if the_movie.valid?
      the_movie.save
      redirect_to("/backdoor", { :notice => "Movie created successfully." })
    else
      redirect_to("/backdoor", { :alert => the_movie.errors.full_messages.to_sentence })
    end
  end

  # INDEX ACTIONS
  def directors_index
    @list_of_directors = Director.all

    render({ :template => "backdoor_templates/directors_index" })
  end

  def actors_index
    @list_of_actors = Actor.all

    render({ :template => "backdoor_templates/actors_index" })
  end

  def movies_index
    @list_of_movies = Movie.all.order({ :year => :desc, :title => :asc })

    render({ :template => "backdoor_templates/movies_index" })
  end

  # EDIT ACTIONS
  def director_show
    the_id = params.fetch("path_id")
    @the_director = Director.where({ :id => the_id }).at(0)
    render({ :template => "backdoor_templates/director_show" })
  end

  def actor_show
    the_id = params.fetch("path_id")
    @the_actor = Actor.where({ :id => the_id }).at(0)
    render({ :template => "backdoor_templates/actor_show" })
  end

  def movie_show
    the_id = params.fetch("path_id")
    @the_movie = Movie.where({ :id => the_id }).at(0)
    render({ :template => "backdoor_templates/movie_show" })
  end

  # UPDATE ACTIONS
  def update_director
    the_id = params.fetch("path_id")
    the_director = Director.where({ :id => the_id }).at(0)

    the_director.first_name = params.fetch("query_first_name")
    the_director.last_name = params.fetch("query_last_name")
    the_director.dob = params.fetch("query_dob")
    the_director.bio = params.fetch("query_bio")
    the_director.image = params.fetch("query_image")

    if the_director.valid?
      the_director.save
      redirect_to("/backdoor/directors/#{the_director.id}", { :notice => "Director updated successfully." })
    else
      redirect_to("/backdoor/directors/#{the_director.id}", { :alert => the_director.errors.full_messages.to_sentence })
    end
  end

  def update_actor
    the_id = params.fetch("path_id")
    the_actor = Actor.where({ :id => the_id }).at(0)

    the_actor.first_name = params.fetch("query_first_name")
    the_actor.last_name = params.fetch("query_last_name")
    the_actor.dob = params.fetch("query_dob")
    the_actor.bio = params.fetch("query_bio")
    the_actor.image = params.fetch("query_image")

    if the_actor.valid?
      the_actor.save
      redirect_to("/backdoor/actors/#{the_actor.id}", { :notice => "Actor updated successfully." })
    else
      redirect_to("/backdoor/actors/#{the_actor.id}", { :alert => the_actor.errors.full_messages.to_sentence })
    end
  end

  def update_movie
    the_id = params.fetch("path_id")
    the_movie = Movie.where({ :id => the_id }).at(0)

    the_movie.title = params.fetch("query_title")
    the_movie.year = params.fetch("query_year")
    the_movie.duration = params.fetch("query_duration")
    the_movie.description = params.fetch("query_description")
    the_movie.image = params.fetch("query_image")
    the_movie.director_id = params.fetch("query_director_id")
    the_movie.released_on = params.fetch("query_released_on", nil)
    the_movie.oscar_cohort = params.fetch("query_oscar_cohort", nil)
    the_movie.result = params.fetch("query_result")

    if the_movie.valid?
      the_movie.save
      redirect_to("/backdoor/movies/#{the_movie.id}", { :notice => "Movie updated successfully." })
    else
      redirect_to("/backdoor/movies/#{the_movie.id}", { :alert => the_movie.errors.full_messages.to_sentence })
    end
  end

  # DESTROY ACTIONS
  def destroy_director
    the_id = params.fetch("path_id")
    the_director = Director.where({ :id => the_id }).at(0)

    the_director.destroy

    redirect_to("/backdoor/directors", { :notice => "Director deleted successfully." })
  end

  def destroy_actor
    the_id = params.fetch("path_id")
    the_actor = Actor.where({ :id => the_id }).at(0)

    the_actor.destroy

    redirect_to("/backdoor/actors", { :notice => "Actor deleted successfully." })
  end

  def destroy_movie
    the_id = params.fetch("path_id")
    the_movie = Movie.where({ :id => the_id }).at(0)

    the_movie.destroy

    redirect_to("/backdoor/movies", { :notice => "Movie deleted successfully." })
  end

  # CREDIT ACTIONS
  def create_credit_from_movie
    movie_id = params.fetch("movie_id")

    the_credit = Credit.new
    the_credit.role = params.fetch("query_role")
    the_credit.actor_id = params.fetch("query_actor_id")
    the_credit.movie_id = movie_id

    if the_credit.valid?
      the_credit.save
      redirect_to("/backdoor/movies/#{movie_id}", { :notice => "Credit added successfully." })
    else
      redirect_to("/backdoor/movies/#{movie_id}", { :alert => the_credit.errors.full_messages.to_sentence })
    end
  end

  def create_credit_from_actor
    actor_id = params.fetch("actor_id")

    the_credit = Credit.new
    the_credit.role = params.fetch("query_role")
    the_credit.actor_id = actor_id
    the_credit.movie_id = params.fetch("query_movie_id")

    if the_credit.valid?
      the_credit.save
      redirect_to("/backdoor/actors/#{actor_id}", { :notice => "Credit added successfully." })
    else
      redirect_to("/backdoor/actors/#{actor_id}", { :alert => the_credit.errors.full_messages.to_sentence })
    end
  end
end
