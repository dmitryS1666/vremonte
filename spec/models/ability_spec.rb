require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'guest' do
    let(:user) {nil}

    it {should be_able_to :read, Request}
    it {should_not be_able_to :manage, :all}
  end

  describe 'user' do
    let(:user) { create(:user) }
    let(:other) { create(:user) }
    let(:request) { create :request, user: user }
    let(:answer) { create :answer, user: user, request: request }
    let(:foreign_answer) { create :answer, user: other, request: request }

    it {should_not be_able_to :manage, :all}
    it {should be_able_to :read, :all}

    it { should be_able_to :create, Request }

    context 'Request' do
      it { should be_able_to :update, request, user: user }
      it { should be_able_to :destroy, request, user: user }
      it { should be_able_to :comment, Request }
      it { should_not be_able_to :vote_up, request, user: user }
      it { should_not be_able_to :vote_down, request, user: user }
      it { should_not be_able_to :vote_reset, request, user: user }
    end
  end

  describe 'admin' do
    let(:user) { create(:user, admin: true ) }

    it {should be_able_to :manage, :all}
  end

end