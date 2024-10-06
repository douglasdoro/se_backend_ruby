# frozen_string_literal: true

include FactoryBot::Syntax::Methods # rubocop:disable Style/MixinUsage

if Rails.env.development?

  # Author
  authors = create_list(:author, 3)

  # Default Author
  matz = create(:author, name: 'Matz')
  create_list(:publication, 20, :published, author: matz)

  # Publications
  # Draft
  create_list(:publication, 20, :draft, author: authors.sample)
  # Published
  create_list(:publication, 20, :published, author: authors.sample)
  # Deleted
  create_list(:publication, 20, :deleted, author: authors.sample)

end
