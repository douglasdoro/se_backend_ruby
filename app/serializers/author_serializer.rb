# frozen_string_literal: true

class AuthorSerializer < ApplicationSerializer
  identifier :id

  fields :name, :email
end
