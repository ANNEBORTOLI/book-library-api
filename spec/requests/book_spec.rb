require 'rails_helper'

RSpec.describe "Books", type: :request do
  # initialize test data
  let!(:books) { create_list(:book, 5) }
  let!(:book) { books.first }


  # Test suite for GET /books
  describe "GET api/v1/books" do
    # make HTTP get request before each example
    before { get '/api/v1/books' }
    it 'returns books' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /books
  describe 'POST /api/v1/books' do
    let(:author) { create(:author) }
    let(:genre) { create(:genre) }
    let(:valid_attributes) { { book: { title: 'new title', publication_year: 200, genre_id: genre.id, author_id: author.id } } }

    context 'when request attributes are valid' do
      before { post '/api/v1/books', params: valid_attributes }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when an invalid request' do
      before { post '/api/v1/books', params: { book: { title: ""} } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for GET /books/:id
  describe "GET /api/v1/books/:id" do
    # make HTTP get request before each example
    before { get "/api/v1/books/#{book.id}" }
    it 'returns one genre based on its id' do
      expect(json).not_to be_empty
      expect(json["id"]).to eq(book.id)
      expect(json["title"]).to eq(book.title)
      expect(json["author"]["id"]).to eq(book.author.id)
      expect(json["author"]["name"]).to eq(book.author.name)
      expect(json["genre"]["id"]).to eq(book.genre.id)
      expect(json["genre"]["name"]).to eq(book.genre.name)
      expect(json["publication_year"]).to eq(book.publication_year)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for PATCH /books/:id
  describe "PATCH /api/v1/books/:id" do
    let(:book) { create(:book) }
    let(:author) { create(:author) }
    let(:genre) { create(:genre) }
    let(:valid_attributes) do
      {
        title: 'Updated Title',
        publication_year: 1,
        author_id: author.id,
        genre_id: genre.id
      }
    end
    before { patch "/api/v1/books/#{book.id}", params: { id: book.id, book: valid_attributes } }
    context 'when book exists' do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
      it "updates the book" do
        book.reload
        expect(book.title).to eq('Updated Title')
        expect(book.publication_year).to eq(1)
        expect(book.author.id).to eq(author.id)
        expect(book.genre.id).to eq(genre.id)
      end
    end
  end
end
