# frozen_string_literal: true

include FactoryBot::Syntax::Methods # rubocop:disable Style/MixinUsage

if Rails.env.development?

  # Default Author
  matz = create_list(:author, 5, name: 'Matz')
  create_list(:publication, 20, :published, author: matz)

  # Publications
  # Draft
  create_list(:publication, 20, :draf)
  # Published
  create_list(:publication, 20, :published)
  # Deleted
  create_list(:publication, 20, :deleted)

end
