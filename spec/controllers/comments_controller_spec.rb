require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  shared_examples 'comments #create' do |context_name|
    context context_name do
      it 'change comments count' do
        expect { subject }.to change(context.comments, :count).by(1)
      end

      it_behaves_like 'invalid params', 'empty body', model: Comment do
        let(:form_params) { { body: '' } }
      end
    end
  end

  describe 'POST #create' do
    let!(:request) { create(:request) }

    let(:form_params) { {} }

    let(:params) do
      { comment: attributes_for(:comment).merge(form_params), format: :js }
    end

    subject { post :create, params: params }


  end
end
