require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'association' do
    it { should belong_to :user }
    it { should have_many :requests }

    it { should validate_presence_of :user_id }
    it { should validate_presence_of :request_id }
    it { should validate_presence_of :body }
  end
end
