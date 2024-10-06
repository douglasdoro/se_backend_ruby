# frozen_string_literal: true

class ErrorSerializer < ApplicationSerializer
  field :status
  field :message
  field :details, default: []
end
