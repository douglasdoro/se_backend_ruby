# frozen_string_literal: true

class V1::AuthorsController < ApplicationController
  def index
    authors = Author.order(created_at: sort_order).then(&paginate)
    render_authors(authors, :ok)
  end

  private

  def render_authors(authors, status)
    render json: AuthorSerializer.render(
      authors,
      root: :authors,
      view: :default,
      meta: meta(authors)
    ), status:
  end
end
