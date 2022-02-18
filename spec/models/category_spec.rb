# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_uniqueness_of(:title).ignoring_case_sensitivity }
  it { is_expected.to have_many(:products) }
end
