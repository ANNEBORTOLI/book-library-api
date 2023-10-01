require 'rails_helper'

RSpec.describe "Genres", type: :request do
  # initialize test data
  let!(:genres) { create_list(:genre, 5) }
  let!(:genre) { genres.first }

  # Test suite for GET /genres
  describe "GET /genres" do
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
    describe "GET /genres/:id" do
      # make HTTP get request before each example
      before { get "/api/v1/genres/#{genre.id}" }
      it 'returns one genre based on its id' do
        expect(json).not_to be_empty
        expect(json).to eq(:genre)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
end
