# frozen_string_literal: true

class EmailService
  def send_message(message)
    Notification::EmailServiceJob.perform_async(message)
  end
end
