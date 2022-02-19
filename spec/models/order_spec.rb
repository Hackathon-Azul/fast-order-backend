require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to validate_presence_of(:client_name) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to belong_to(:table) }
  it { is_expected.to belong_to(:user) }
end
