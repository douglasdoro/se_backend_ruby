# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Publication do
  describe 'validations' do
    subject { build(:publication) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }

    it { is_expected.to define_enum_for(:status).with_values(draft: 0, published: 10, deleted: 20) }

    it 'has a valid Publicaiton' do
      expect(subject).to be_valid # rubocop:disable RSpec/NamedSubject
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:author) }
  end
end
