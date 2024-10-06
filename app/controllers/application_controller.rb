# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pagination

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(exception)
    error_response = {
      status: 404,
      message: 'Not found',
      details: exception.message
    }

    render json: ErrorSerializer.render(error_response, root: :error), status: :not_found
  end

  def render_error(message, status, obj)
    error_response = {
      status:,
      message:,
      details: obj&.errors&.full_messages
    }
    render json: ErrorSerializer.render(error_response, root: :error), status:
  end

  def meta(collection)
    {
      # Converted to array do not query again
      count: collection&.to_a&.count&.to_s,
      page: params[:page] || '0',
      per_page: params[:per_page] || '0'

    }
  end

  def sort_order
    params[:sort] == 'asc' ? :asc : :desc
  end
end
