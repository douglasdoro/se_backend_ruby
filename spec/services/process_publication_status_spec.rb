# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessPublicationStatus, type: :service do
  context 'when switch status to :published' do
    let(:publication) { build(:publication, :draft) }

    it 'updates the publication status to published' do
      expected_publication = described_class.new(publication, :published).call

      expect(expected_publication.status).to eq('published')
      expect(expected_publication.published_at).not_to be_nil
      expect(expected_publication.deleted_at).to be_nil
    end
  end

  context 'when switch status to :deleted' do
    let(:publication) { build(:publication, :published) }

    it 'updates the publication status to deleted' do
      expected_publication = described_class.new(publication, :deleted).call

      expect(expected_publication.status).to eq('deleted')
      expect(expected_publication.published_at).to be_nil
      expect(expected_publication.deleted_at).not_to be_nil
    end
  end

  context 'when switch status to :draft' do
    let(:publication) { build(:publication, :published) }

    it 'updates the publication status to draft' do
      expected_publication = described_class.new(publication, :draft).call

      expect(expected_publication.status).to eq('draft')
      expect(expected_publication.published_at).to be_nil
      expect(expected_publication.deleted_at).to be_nil
    end
  end
end
