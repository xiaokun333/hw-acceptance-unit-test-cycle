class AddDirectorsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :directors, :string
  end
end
