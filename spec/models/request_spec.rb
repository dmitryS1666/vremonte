require 'rails_helper'

RSpec.describe Request, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :owner_id }
end