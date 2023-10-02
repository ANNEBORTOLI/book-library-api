class Api::V1::AuthorsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_author, only: [ :show, :update, :destroy ]

  def index
    @authors = Author.all
  end

  def show
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      render :show, status: :created #201
    else
      render_error
    end
  end

  def update
    if @author.update(author_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @author.destroy
    head :no_content
  end

  private

  def set_author
    @author = Author.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Author not found' }, status: :not_found
  end

  def author_params
    params.require(:author).permit(:name)
  end

  def render_error
    render json: { errors: @author.errors.full_messages },
    status: :unprocessable_entity #422
  end
end
