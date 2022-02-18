require 'rails_helper'

RSpec.describe Table, type: :model do
  it { is_expected.to validate_presence_of :table_number }
  it { is_expected.to validate_presence_of :avaliable_table }
  it { is_expected.to validate_numericality_of(:table_number).only_integer.is_greater_than_or_equal_to(0) }
end
