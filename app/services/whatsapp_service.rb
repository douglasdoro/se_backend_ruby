# frozen_string_literal: true

class WhatsappService
  def send_message(message)
    Notification::WhatsappServiceJob.perform_async(message)
  end
end
