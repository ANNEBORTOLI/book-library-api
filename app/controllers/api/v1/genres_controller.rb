class Api::V1::GenresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_genre, only: [ :show, :update, :destroy ]

  def index
    @genres = Genre.all
  end

  def show
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      render :show, status: :created #201
    else
      render_error
    end
  end

  def update
    if @genre.update(genre_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @genre.destroy
    head :no_content
  end

  private

  def set_genre
    begin
      @genre = Genre.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: 'Genre not found' }, status: :not_found
    end
  end

  def genre_params
    params.require(:genre).permit(:name)
  end

  def render_error
    render json: { errors: @genre.errors.full_messages },
    status: :unprocessable_entity #422
  end
end
