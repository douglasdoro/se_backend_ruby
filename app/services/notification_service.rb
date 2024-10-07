# frozen_string_literal: true

class NotificationService
  TEMPLATE_UPDATE = 'Autor, a publicação com o id ID foi atualizada'
  TEMPLATE_CREATE = 'Autor, uma nova publicação foi driada com o ID'

  def initialize(publication_id, type, services)
    @publication_id = publication_id
    @type = type
    @services = services
  end

  def send
    @services.each do |service|
      message = build_message

      service.send_message(message)
    end
  end

  private

  def build_message
    case @type
    when :update
      TEMPLATE_UPDATE.gsub('ID', @publication_id)
    when :create
      TEMPLATE_CREATE.gsub('ID', @publication_id)
    end
  end
end
