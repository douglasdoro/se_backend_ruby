# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::PublicationsController' do
  let(:author) { create(:author) }
  let!(:publication) { create(:publication, author:, status: 'published') }
  let(:publication_params) { { publication: { title: 'New Title', body: 'New Body', author_id: author.id } } }

  describe 'GET /v1/publications' do
    it 'returns a list of published publications' do
      get v1_publications_path

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body[:publications]).not_to be_empty
    end
  end

  describe 'GET /v1/publications/:id' do
    context 'when the publication exists' do
      it 'returns the publication' do
        get v1_publication_path(publication.id)

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body[:publication][:id]).to eq(publication.id)
      end
    end

    context 'when the publication does not exist' do
      it 'returns a 404 status' do
        get v1_publication_path(-1)

        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body[:error][:message]).to eq('Not found')
      end
    end
  end

  describe 'POST /v1/publications' do
    before do
      # rubocop:disable RSpec/AnyInstance
      allow_any_instance_of(EmailService).to receive(:send_message)
      allow_any_instance_of(WhatsappService).to receive(:send_message)
      # rubocop:enable RSpec/AnyInstance
    end

    context 'with valid parameters' do
      it 'creates a new publication' do
        expect do
          post v1_publications_path, params: publication_params
        end.to change(Publication, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response.parsed_body[:publication][:title]).to eq('New Title')
      end
    end

    context 'with invalid parameters' do
      it 'returns a 422 status' do
        invalid_params = { publication: { title: '', body: '', author_id: author.id } }
        post v1_publications_path, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body).to include(:title, :body)
      end
    end
  end

  describe 'PUT /v1/publications/:id' do
    before do
      # rubocop:disable RSpec/AnyInstance
      allow_any_instance_of(EmailService).to receive(:send_message)
      allow_any_instance_of(WhatsappService).to receive(:send_message)
      # rubocop:enable RSpec/AnyInstance
    end

    context 'with valid parameters' do
      it 'updates the publication' do
        patch v1_publication_path(publication.id), params: publication_params

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body[:publication][:title]).to eq('New Title')
      end
    end

    context 'with invalid parameters' do
      it 'returns a 422 status' do
        invalid_params = { publication: { title: '', body: '', author_id: author.id } }
        patch v1_publication_path(publication.id), params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body[:error][:message]).to eq('not updated')
      end
    end
  end

  describe 'DELETE /v1/publications/:id' do
    it 'soft deletes the publication' do
      delete v1_publication_path(publication.id)

      expect(response).to have_http_status(:no_content)
      publication.reload
      expect(publication.status).to eq('deleted')
      expect(publication.published_at).to be_nil
      expect(publication.deleted_at).not_to be_nil
    end
  end

  describe 'GET /v1/authors/:author_id/publications' do
    context 'when the author exists' do
      it 'returns the list of published publications for the author' do
        get publications_v1_author_path(author.id)

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['publications']).not_to be_empty
        expect(response.parsed_body['publications'].first['author']).to eq(author.name)
      end
    end

    context 'when the author does not exist' do
      it 'returns a 404 status' do
        get publications_v1_author_path(-1)

        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body['error']['message']).to eq('Not found')
      end
    end
  end
end
