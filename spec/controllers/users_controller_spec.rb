require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #show' do
    before{ sign_in user }
    let(:user) { create(:user) }
    before { get :show, params: { id: user }}

    it 'assings the requested user to @user' do
      expect(assigns(:user)).to eq user
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    before{ sign_in user }
    let(:user) { create(:user) }
    before { get :edit, params: { id: user }}

    it 'assigns the requested "user" to @user' do
      expect(assigns(:user)).to eq user
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATH #update' do
    let(:user) { create(:user) }

    context 'valid attributes' do
      it 'assigns the requested "user" to @user' do
        patch :update, params: { id: user, user: attributes_for(:user) }
        expect(assigns(:user)).to eq user
      end

      it 'change user attributes' do
        patch :update, params: { id: user, user: { email: 'new@email.com' } }
        user.reload
        expect(user.email).to eq 'new@email.com'
      end

      it 'redirect to the update user' do
        patch :update, params: { id: user, user: attributes_for(:user) }
        expect(response).to redirect_to user_path(assigns(:user))
      end
    end
  end

  describe 'DELETE #destroy' do
    before{ sign_in user }

    let(:user) { create(:user) }

    it 'deletes user' do
      expect { delete :destroy, params: { id: user } }.to change(User, :count).by(-1)
    end

    it 'redirect to sign_in view' do
      delete :destroy, params: { id: user }
      expect(response).to redirect_to new_user_session_path
    end
  end

end
