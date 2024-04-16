# frozen_string_literal: true

module Integrations
  module Aggregator
    class PerformSyncJob < ApplicationJob
      queue_as 'integrations'

      retry_on LagoHttpClient::HttpError, wait: :exponentially_longer, attempts: 3

      def perform(integration:)
        result = Integrations::Aggregator::SyncService.call(integration:)
        result.raise_if_error!
      end
    end
  end
end
