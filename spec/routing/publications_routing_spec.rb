# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::PublicationsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/publications').to route_to('v1/publications#index')
    end

    it 'routes to #show' do
      expect(get: '/v1/publications/1').to route_to('v1/publications#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/v1/publications').to route_to('v1/publications#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/v1/publications/1').to route_to('v1/publications#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/v1/publications/1').to route_to('v1/publications#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/v1/publications/1').to route_to('v1/publications#destroy', id: '1')
    end
  end
end
