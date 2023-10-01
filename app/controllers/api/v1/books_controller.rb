class Api::V1::BooksController < ApplicationController
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

  private

  def set_book
    begin
      @book = Book.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: 'Book not found' }, status: :not_found
    end
  end

  def book_params
    params.require(:book).permit(:title, :publication_year, :author_id, :genre_id)
  end

  def render_error
    render json: { errors: @book.errors.full_messages },
    status: :unprocessable_entity #422
  end
end
