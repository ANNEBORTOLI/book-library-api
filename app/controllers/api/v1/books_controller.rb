class Api::V1::BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_book, only: [ :show, :update, :destroy ]

  def index
    @books = Book.all
  end

  def show
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      render :show, status: :created #201
    else
      render_error
    end
  end

  def update
    if @book.update(book_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @book.destroy
    head :no_content
  end

  def search
    title = params[:title]
    publication_year = params[:publication_year]
    author_name = params[:author_name]
    genre_name = params[:genre_name]

    @books = Book.all
    @books = @books.where('title ILIKE ?', "%#{title}%") if title.present?
    @books = @books.where(publication_year) if publication_year.present?

    if author_name.present?
      @books = @books.joins(:author).where('authors.name ILIKE ?', "%#{author_name}%")
    end
    if genre_name.present?
      @books = @books.joins(:genre).where('genres.name ILIKE ?', "%#{genre_name}%")
    end

    render :search
  end

  private

  def set_book
    @book = Book.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Book not found' }, status: :not_found
  end

  def book_params
    params.require(:book).permit(:title, :publication_year, :author_id, :genre_id)
  end

  def render_error
    render json: { errors: @book.errors.full_messages },
    status: :unprocessable_entity #422
  end
end
