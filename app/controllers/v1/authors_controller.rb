# frozen_string_literal: true

class V1::AuthorsController < ApplicationController
  def index
    @authors = Author.all
    render json: AuthorSerializer.render(@authors, root: :authors), status: :ok
  end
end
