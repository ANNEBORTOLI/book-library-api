require 'rails_helper'

RSpec.describe "Genres", type: :request do
  # initialize test data
  let!(:genres) { create_list(:genre, 5) }
  let!(:genre) { genres.first }

  # Test suite for GET /genres
  describe "GET api/v1/genres" do
    # make HTTP get request before each example
    before { get '/api/v1/genres' }
    it 'returns genres' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /genres/:id
  describe "GET /api/v1/genres/:id" do
    # make HTTP get request before each example
    before { get "/api/v1/genres/#{genre.id}" }
    it 'returns one genre based on its id' do
      expect(json).not_to be_empty
      expect(json["id"]).to eq(genre.id)
      expect(json["name"]).to eq(genre.name)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /genres
  describe 'POST /api/v1/genres' do
    let(:valid_attributes) { { name: 'new genre'} }

    context 'when request attributes are valid' do
      before { post '/api/v1/genres', params: valid_attributes }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when an invalid request' do
      before { post '/api/v1/genres', params: {} }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PATCH /genres/:id
  describe "PATCH /api/v1/genres/:id" do
    let(:valid_attributes) {{ genre: { name: 'Update test' }}}
    before { patch "/api/v1/genres/#{genre.id}", params: valid_attributes }

    context 'when genre exists' do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
      it "updates the genre" do
        updated_genre = Genre.find(genre.id)
        expect(updated_genre.name).to eq('Update test')
      end
    end

    context 'when the genre does not exist' do
      let(:genre_invalid_id) { 0 }
      before { patch "/api/v1/genres/#{genre_invalid_id}", params: valid_attributes }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for DELETE /genres/:id
  describe 'DELETE api/v1/genres/:id' do
    before { delete "/api/v1/genres/#{genre.id}" }

    context 'when genre exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it "deletes the genre" do
        expect { Genre.find(genre.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when the genre does not exist' do
      before { patch "/api/v1/genres/#{genre.id}" }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
