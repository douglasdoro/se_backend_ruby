# frozen_string_literal: true

class V1::PublicationsController < ApplicationController
  before_action :set_publication, only: %i[show destroy]
  before_action :set_author, only: %i[create]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    publications = Publication.includes(:author).where(status: Publication.status(:published))

    render_publications(publications, :ok)
  end

  def show
    render json: PublicationSerializer.render(
      @publication,
      root: :publication,
      view: :with_author_name
    ), status: :ok
  end

  def create
    @publication = @author.publications.new(publication_params)

    if @publication.save
      render json: PublicationSerializer.render(
        @publication,
        root: :publication,
        view: :with_author_name
      ), status: :created
    else
      render json: @publication.errors, status: :unprocessable_entity
    end
  end

  def update
    @publication = Publication.find_by(id: params[:id], author_id: params[:publication][:author_id])

    raise ActiveRecord::RecordNotFound if @publication.nil?

    if @publication.update(publication_params)
      render json: PublicationSerializer.render(
        @publication,
        root: :publication,
        view: :with_author_name
      ), status: :ok
    else
      render_error('not updated', :unprocessable_entity, @publication)
    end
  end

  def destroy
    @publication.status = Publication.status(:deleted)
    @publication.deleted_at = DateTime.now
    @publication.published_at = nil

    if @publication.save
      render status: :no_content
    else
      render_error('not updated', :unprocessable_entity, @publication)
    end
  end

  private

  def set_publication
    @publication = Publication.find(params[:id])
  end

  def set_author
    @author = Author.find(params[:publication][:author_id])
  end

  def publication_params
    params.require(:publication).permit(:title, :body, :author_id)
  end

  def render_publications(publications, status)
    render json: PublicationSerializer.render(
      publications.then(&paginate),
      root: :publications,
      view: :with_author_name,
      meta: meta(publications)
    ), status:
  end

  def meta(publications)
    {
      # Converted to array do not query again
      count: publications.to_a.count.to_s,
      page: params[:page],
      per_page: params[:per_page]

    }
  end
end
