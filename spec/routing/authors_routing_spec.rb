# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::AuthorsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/authors').to route_to('v1/authors#index')
    end
  end
end
