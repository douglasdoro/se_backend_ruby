# frozen_string_literal: true

include FactoryBot::Syntax::Methods # rubocop:disable Style/MixinUsage

if Rails.env.development?

  # Authors
  create_list(:author, 5)
end
