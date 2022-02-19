require 'rails_helper'

RSpec.describe Bill, type: :model do
  it { is_expected.to validate_presence_of(:status_bill) }
  it { is_expected.to belong_to(:order) }
end
