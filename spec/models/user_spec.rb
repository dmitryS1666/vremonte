require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:user) { create(:user) }
  let!(:request) { create(:request, user: user) }
  let!(:comment) { create(:comment, user: user) }
  let!(:another_request) { create(:request) }
  let!(:another_comment) { create(:comment) }

  context 'association' do
    it { should have_many(:requests).dependent :destroy }
    it { should have_many(:comments).dependent :destroy }
    it { should have_many(:authorizations)}
  end

  it { should validate_presense_of :email }
  it { should validate_presense_of :password }

  context 'User is an author of' do

    context 'request' do
      it 'returns true if user is an author' do
        expect(user).to be_author(request)
      end

      it 'returns false if user is not an author' do
        expect(user).to_not be_author(another_request)
      end
    end

    context 'comment' do
      it 'returns true if user is an author' do
        expect(user).to be_author(comment)
      end

      it 'returns false if user is not an author' do
        expect(user).to_not be_author(another_comment)
      end
    end
  end

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'vkontakte', uid: '123456') }

    context 'user already has authorization' do
      it 'returns the user' do
        user.authorizations.create(provider: 'vkontakte', uid: '123456')

        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has not authorization' do
      context 'user already exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'vkontakte', uid: '123456', info: { email: user.email }) }

        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates authorization for user' do
          expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end

        it 'creates authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end

      context 'user does not exist' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'vkontakte', uid: '123456', info: { email: 'test-test@test.com' }) }

        it 'creates new user' do
          expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end

        it 'returns new user' do
          expect(User.find_for_oauth(auth)).to be_a(User)
        end

        it 'fills user email' do
          user = User.find_for_oauth(auth)
          expect(user.email).to eq auth.info[:email]
        end

        it 'creates authorizations for user' do
          user = User.find_for_oauth(auth)
          expect(user.authorizations).to_not be_empty
        end

        it 'creates authorizations with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
      end
    end
  end
end
