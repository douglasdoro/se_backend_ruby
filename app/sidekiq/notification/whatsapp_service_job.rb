# frozen_string_literal: true

module Notification
  class WhatsappServiceJob
    include Sidekiq::Job

    def perform(message)
      # rubocop:disable Rails/Output
      puts '*' * 20
      puts '*** Sending WHATSAPP ***'
      puts "MESSAGE: #{message}"
      puts '*' * 20
      # rubocop:enable Rails/Output
    end
  end
end
