require 'rails_helper'

RSpec.describe "Authors", type: :request do
  # initialize test data
  let!(:authors) { create_list(:author, 5) }
  let!(:author) { authors.first }

  # Test suite for GET /authors
  describe "GET api/v1/authors" do
    # make HTTP get request before each example
    before { get '/api/v1/authors' }
    it 'returns authors' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /authors/:id
  describe "GET /api/v1/authors/:id" do
    # make HTTP get request before each example
    before { get "/api/v1/authors/#{author.id}" }
    it 'returns one author based on its id' do
      expect(json).not_to be_empty
      expect(json["id"]).to eq(author.id)
      expect(json["name"]).to eq(author.name)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /authors
  describe 'POST /api/v1/authors' do
    let(:valid_attributes) { { author: { name: 'new author'} } }

    context 'when request attributes are valid' do
      before { post '/api/v1/authors', params: valid_attributes }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when an invalid request' do
      before { post '/api/v1/authors', params: { author: { name: ""} } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PATCH /authors/:id
  describe "PATCH /api/v1/authors/:id" do
    let(:valid_attributes) {{ author: { name: 'Update test' }}}
    before { patch "/api/v1/authors/#{author.id}", params: valid_attributes }

    context 'when author exists' do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
      it "updates the author" do
        updated_author = Author.find(author.id)
        expect(updated_author.name).to eq('Update test')
      end
    end

    context 'when the author does not exist' do
      let(:author_invalid_id) { 0 }
      before { patch "/api/v1/authors/#{author_invalid_id}", params: valid_attributes }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for DELETE /authors/:id
  describe 'DELETE api/v1/authors/:id' do
    before { delete "/api/v1/authors/#{author.id}" }

    context 'when author exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it "deletes the author" do
        expect { Author.find(author.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when the author does not exist' do
      before { patch "/api/v1/authors/#{author.id}" }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
