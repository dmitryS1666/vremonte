require 'rails_helper'

RSpec.describe RequestsController, type: :controller do
  let(:request) { create(:request) }

  describe 'GET #index' do
    let(:requests) { create_list(:request, 2) }
    before do
      @requests = create_list(:request, 2)
      get :index
    end

    it 'array of all requests' do
      expect(assigns(:requests)).to match_array(@requests)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:requests) { create(:request) }
    before { get :show, params: { id: requests }}

    it 'assings the requested "request" to @request' do
      expect(assigns(:request)).to eq requests
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assings a new Request to @request' do
      expect(assigns(:request)).to be_a_new(Request)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    let(:request) { create(:request) }
    before { get :edit, params: { id: request }}

    it 'assigns the requested "requesst" to @requesst' do
      expect(assigns(:request)).to eq request
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save the new request in the database' do
        expect { post :create, params: { request: attributes_for(:request) }}.to change(Request, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { request: attributes_for(:request) }
        expect(response).to redirect_to request_path(assigns(:request))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the request' do
        expect { post :create, params: { request: attributes_for(:invalid_request) } }.to_not change(Request, :count)
      end

      it 're-renders new view' do
        post :create, params: { request: attributes_for(:invalid_request) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATH #update' do
    let(:request) { create(:request) }

    context 'valid attributes' do
      it 'assigns the requested "request" to @request' do
        patch :update, params: { id: request, request: attributes_for(:request) }
        expect(assigns(:request)).to eq request
      end

      it 'change request attributes' do
        patch :update, params: { id: request, request: { title: 'new title request', body: 'new body', owner_id: 1} }
        request.reload
        expect(request.title).to eq 'new title request'
        expect(request.body).to eq 'new body'
      end

      it 'redirect to the update request' do
        patch :update, params: { id: request, request: attributes_for(:request) }
        expect(response).to redirect_to request_path(assigns(:request))
      end
    end

    context 'invalid attributes' do
      before { patch :update, params: { id: request, request: { title: 'new string', body: nil, owner_id: nil }} }
      it 'does not change request attributes' do
        request.reload
        expect(request.title).to eq 'MyStringTitle'
        expect(request.body).to eq 'MyText'
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { request }

    it 'deletes request' do
      expect { delete :destroy, params: { id: request } }.to change(Request, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: request }
      expect(response).to redirect_to request
    end
  end

end
