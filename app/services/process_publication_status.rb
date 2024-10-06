# frozen_string_literal: true

class ProcessPublicationStatus
  def initialize(publication, status)
    @publication = publication
    @status = status.to_sym
  end

  def call # rubocop:disable Metrics/AbcSize
    case @status
    when :draft
      @publication.status = Publication.statuses[:draft]
      @publication.published_at = nil
      @publication.deleted_at = nil
    when :deleted
      @publication.status = Publication.statuses[:deleted]
      @publication.deleted_at = DateTime.now
      @publication.published_at = nil
    when :published
      @publication.status = Publication.statuses[:published]
      @publication.published_at = DateTime.now
      @publication.deleted_at = nil
    end
    @publication
  end
end
