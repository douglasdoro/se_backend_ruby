# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe '.create' do
    context 'when successes' do
      let(:expected_author) { build_stubbed(:author) }

      it 'returns a valid Author' do
        new_author = described_class.create(name: expected_author.name, email: expected_author.email)

        expect(new_author.valid?).to be true
        expect(new_author.name).to eq(expected_author.name)
        expect(new_author.email).to eq(expected_author.email)
      end
    end

    context 'when fails' do
      let(:invalid_author) { build_stubbed(:author, email: 'invalid') }

      it 'returns a false when Authors email is invalid' do
        new_author = described_class.create(name: invalid_author.name, email: invalid_author.email)

        expect(new_author.valid?).to be false
      end
    end
  end
end
