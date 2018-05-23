require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #show' do
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
    let(:user) { create(:user) }
    before { get :edit, params: { id: user }}

    it 'assigns the requested "user" to @user' do
      expect(assigns(:user)).to eq user
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  # describe 'PATH #update' do
  #   let(:request) { create(:request) }
  #
  #   context 'valid attributes' do
  #     it 'assigns the requested "request" to @request' do
  #       patch :update, params: { id: request, request: attributes_for(:request) }
  #       expect(assigns(:request)).to eq request
  #     end
  #
  #     it 'change request attributes' do
  #       patch :update, params: { id: request, request: { title: 'new title request', body: 'new body', owner_id: 1} }
  #       request.reload
  #       expect(request.title).to eq 'new title request'
  #       expect(request.body).to eq 'new body'
  #     end
  #
  #     it 'redirect to the update request' do
  #       patch :update, params: { id: request, request: attributes_for(:request) }
  #       expect(response).to redirect_to request_path(assigns(:request))
  #     end
  #   end
  #
  #   context 'invalid attributes' do
  #     before { patch :update, params: { id: request, request: { title: 'new string', body: nil, owner_id: nil }} }
  #     it 'does not change request attributes' do
  #       request.reload
  #       expect(request.title).to eq 'MyStringTitle'
  #       expect(request.body).to eq 'MyText'
  #     end
  #
  #     it 're-renders edit view' do
  #       expect(response).to render_template :edit
  #     end
  #   end
  # end


  describe 'DELETE #destroy' do
    before { request }

    it 'deletes user' do
      expect { delete :destroy, params: { id: user } }.to change(User, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: user }
      expect(response).to redirect_to user
    end
  end

end
