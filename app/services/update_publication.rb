# frozen_string_literal: true

class UpdatePublication
  def initialize(publication_id, publication_params)
    @publication_id = publication_id
    @publication_params = publication_params
  end

  def save
    find_publication
    process_status
    assign_attributes
    update_cache

    [@publication.save, @publication]
  end

  private

  def find_publication
    @publication = Publication.find_by(id: @publication_id, author_id: @publication_params[:author_id])

    raise ActiveRecord::RecordNotFound if @publication.nil?
  end

  def process_status
    return unless @publication_params[:status]

    @publication = ProcessPublicationStatus.new(@publication,
                                                @publication_params[:status]).call
  end

  def assign_attributes
    @publication.assign_attributes(@publication_params)
  end

  def update_cache
    Rails.cache.delete("publication/#{@publication.id}")
  end
end
