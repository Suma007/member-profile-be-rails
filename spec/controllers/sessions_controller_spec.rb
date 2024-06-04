# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController do
  let!(:member) { create(:member) }

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'logs in the member' do
        post :create, params: { session: { name: member.name, password: member.password } }
        expect(session[:member_id]).to eq(member.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid credentials' do
      it 'does not log in the member' do
        post :create, params: { session: { name: member.name, password: 'wrongpassword' } }
        expect(session[:member_id]).to be_nil
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'logs out the member' do
      post :create, params: { session: { name: member.name, password: member.password } }
      delete :destroy
      expect(session[:member_id]).to be_nil
      expect(response).to have_http_status(:ok)
    end
  end
end
