# frozen_string_literal: true

class Publication < ApplicationRecord
  belongs_to :author

  enum :status, {
    draft: 0,
    published: 10,
    deleted: 20
  }

  validates :title, presence: true, length: { in: 3..40 }
  validates :body, presence: true
  validates :status, inclusion: { in: statuses.keys }
end
