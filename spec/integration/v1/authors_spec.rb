# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/v1/authors' do
  path '/v1/authors' do
    get('list Authors') do
      tags 'Authors'
      produces 'application/json'

      response(200, 'Authors found') do
        schema type: :object, properties: {
          authors: {
            type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :string, format: :uuid },
                name: { type: :string },
                email: { type: :string }
              },
              required: %w[id name email]
            }
          },
          meta: {
            type: :object,
            properties: {
              count: { type: :string },
              per_page: { type: :string },
              page: { type: :string }
            }
          }
        }

        let(:authors) { create_list(:author, 3) }

        run_test!
      end

      response(200, 'no authors found') do
        schema type: :object, properties: {
          authors: { type: :array, items: { type: :object } },
          meta: {
            type: :object,
            properties: {
              count: { type: :string },
              per_page: { type: :string },
              page: { type: :string }
            }
          }
        }

        let(:authors) { [] }
        run_test!
      end
    end
  end
end
