# frozen_string_literal: true

class CreatePublication
  def initialize(author, publication_params)
    @author = author
    @publication_params = publication_params
  end

  def save
    @publication = @author.publications.new(@publication_params)

    saved = @publication.save

    send_notification if saved

    [saved, @publication]
  end

  private

  def send_notification
    services = [WhatsappService.new]

    NotificationService.new(@publication.id, :update, services).send
  end
end
