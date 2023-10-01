class Api::V1::GenresController < ApplicationController
  before_action :set_genre, only: [ :show, :update, :destroy ]

  def index
    @genres = Genre.all
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end

  def render_error
    render json: { errors: @genre.errors.full_messages },
    status: :unprocessable_entity #422
  end
end
