# frozen_string_literal: true

class V1::PublicationsController < ApplicationController
  before_action :set_publication, only: %i[destroy]
  before_action :set_author, only: %i[create index_for_author]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    publications = Publication.includes(:author)
                              .published
                              .order(published_at: sort_order)
                              .then(&paginate)

    render_publications(publications, :ok)
  end

  # Thinking RESTful
  # GET /authors/:author_id/publications
  def index_for_author
    publications = @author.publications
                          .published
                          .order(published_at: sort_order)
                          .then(&paginate)

    render_publications(publications, :ok)
  end

  def show
    publication = Rails.cache.fetch("publication/#{params[:id]}", expires_in: 5.minutes) do
      Publication.includes(:author).find(params[:id])
    end

    render json: PublicationSerializer.render(
      publication,
      root: :publication,
      view: :with_author_name
    ), status: :ok
  end

  def create
    save, publication = CreatePublication.new(@author, publication_params).save

    if save
      render json: PublicationSerializer.render(
        publication,
        root: :publication,
        view: :with_author_name
      ), status: :created
    else
      render json: publication.errors, status: :unprocessable_entity
    end
  end

  def update
    save, publication = UpdatePublication.new(params[:id], publication_params).save

    if save
      render json: PublicationSerializer.render(
        publication,
        root: :publication,
        view: :with_author_name
      ), status: :ok
    else
      render_error('not updated', :unprocessable_entity, publication)
    end
  end

  def destroy
    @publication = ProcessPublicationStatus.new(@publication, :deleted).call

    if @publication.save
      render status: :no_content
    else
      render_error('not deleted', :unprocessable_entity, @publication)
    end
  end

  private

  def set_publication
    @publication = Publication.find(params[:id])
  end

  def set_author
    return @author = Author.find(params[:id]) if params[:action] == 'index_for_author'

    @author = Author.find(params[:publication][:author_id])
  end

  def publication_params
    params.require(:publication).permit(:title, :body, :status, :author_id)
  end

  def render_publications(publications, status)
    render json: PublicationSerializer.render(
      publications,
      root: :publications,
      view: :with_author_name,
      meta: meta(publications)
    ), status:
  end
end
