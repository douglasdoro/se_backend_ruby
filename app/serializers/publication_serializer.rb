# frozen_string_literal: true

class PublicationSerializer < ApplicationSerializer
  identifier :id

  view :default do
    fields :title, :body, :published_at
  end

  view :with_author_name do
    field :title
    field :body
    field :published_at
    field :author do |publication, _|
      publication.author.name
    end
  end
end
