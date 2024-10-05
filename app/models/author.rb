# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :publications, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
