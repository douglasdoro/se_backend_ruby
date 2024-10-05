# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::AuthorsController' do
  describe 'GET /' do
    let(:authors_list_size) { 10 }

    before do
      create_list(:author, authors_list_size)

      get '/v1/authors', headers: { HTTP_ACCEPT: 'application/json' }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a list of Authors' do
      expected_authors = response.parsed_body[:authors]

      expect(expected_authors.count).to eq(authors_list_size)
    end

    it 'returns correct fields for each Author' do
      expected_authors = response.parsed_body[:authors]

      expect(expected_authors[0]).to include(
        'id', 'name', 'email'
      )
    end
  end
end
