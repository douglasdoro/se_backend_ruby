# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'V1::PublicationsController' do
  let(:author) { create(:author) }
  let!(:publication) { create(:publication, :published, author:) }
  let(:publication_params) { { publication: { title: 'New Title', body: 'New Body', author_id: author.id } } }

  path '/v1/publications' do
    before do
      create_list(:publication, 5, :published)
    end

    get 'Retrieves a list of published publications' do
      tags 'Publications'
      produces 'application/json'

      response '200', 'publications found' do
        schema type: :object,
               properties: {
                 publications: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :string },
                       title: { type: :string },
                       body: { type: :string },
                       author: { type: :string }
                     }
                   }
                 }
               }

        run_test!
      end
    end

    post 'Creates a new publication' do
      tags 'Publications'
      consumes 'application/json'
      parameter name: :publication, in: :body, schema: {
        type: :object,
        properties: {
          publication: {
            type: :object,
            properties: {
              title: { type: :string },
              body: { type: :string },
              author_id: { type: :integer }
            },
            required: %w[title body author_id]
          }
        }
      }

      response '201', 'publication created' do
        let(:publication) { publication_params }

        run_test!
      end

      response '422', 'invalid request' do
        let(:publication) { { publication: { title: '', body: '', author_id: author.id } } }

        run_test!
      end
    end
  end

  path '/v1/publications/{id}' do
    parameter name: :id, in: :path, type: :string

    let(:pub) { create(:publication, :published, author:) }

    # before do
    #   create_list(:publication, 5, :published)
    # end

    get 'Retrieves a specific publication' do
      tags 'Publications'
      produces 'application/json'

      response '200', 'publication found' do
        schema type: :object,
               properties: {
                 publication: {
                   type: :object,
                   properties: {
                     id: { type: :string },
                     title: { type: :string },
                     body: { type: :string },
                     author: { type: :string }
                   }
                 }
               }
        let(:id) { publication.id }

        run_test!
      end

      response '404', 'publication not found' do
        let(:id) { '-1' }

        run_test!
      end
    end

    put 'Updates a specific publication' do
      tags 'Publications'
      consumes 'application/json'
      parameter name: :publication, in: :body, schema: {
        type: :object,
        properties: {
          publication: {
            type: :object,
            properties: {
              id: { type: :string },
              title: { type: :string },
              body: { type: :string },
              author_id: { type: :string }
            },
            required: %w[title body author_id]
          }
        }
      }

      response '200', 'publication updated' do
        let(:id) { pub.id }
        let(:publication) { publication_params }

        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { pub.id }
        let(:publication) { { publication: { title: '', body: '', author_id: author.id } } }

        run_test!
      end

      response '404', 'publication not found' do
        let(:id) { -1 }
        let(:publication) { publication_params }

        run_test!
      end
    end

    delete 'Soft deletes a specific publication' do
      tags 'Publications'

      response '204', 'publication deleted' do
        let(:id) { publication.id }

        run_test!
      end
    end
  end
end
