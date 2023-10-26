require 'rails_helper'

describe MoviesController do
  before(:all) do
    if Movie.where(director: "Tom Hooper").empty?
      Movie.create(title: "Les Misérables", director: "Tom Hooper", rating: "PG-13", release_date: "2012-12-25")
      Movie.create(title: "The Danish Girl", director: "Tom Hooper", rating: "R", release_date: "2016-01-01")
    end

    if Movie.where(title: "Cats").empty?
      Movie.create(title: "Cats",
                   rating: "PG", release_date: "1998-10-05", director: "David Mallet")
    end
  end

  describe 'searching by directors' do
    it 'returns the correct matches for movies by the same director' do
      movie = Movie.find_by_title("Les Misérables")
      movie_by_director = Movie.search_directors(movie.director).where.not(title: "Les Misérables")

      expect(movie_by_director).to_not be_empty
    end
    it 'returns nothing for movies by different directors' do
      movie = Movie.find_by_title("Cats")
      movie_by_director = Movie.search_directors(movie.director).where.not(title: "Cats")
      expect(movie.director).not_to be_empty
      expect(movie_by_director).to be_empty
    end
  end
end