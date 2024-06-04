# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MembersController do
  describe 'POST #create' do
    let(:member_attributes) { attributes_for(:member) }

    context 'with valid attributes' do
      it 'creates a new member' do
        expect do
          post :create, params: { member: member_attributes }
        end.to change(Member, :count).by(1)
        expect(Sidekiq::Worker.jobs.size).to eq(1)
      end

      it 'redirects to new member' do
        post :create, params: { member: member_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_member) { attributes_for(:member, name: nil) }

      it 'does not create a new member' do
        expect do
          post :create, params: { member: invalid_member }
        end.not_to change(Member, :count)
      end

      it 'returns an unprocessable entity status' do
        post :create, params: { member: invalid_member }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST #add_friend' do
    let(:member) { create(:member) }
    let(:friend) { create(:member) }

    context 'when a friend is added successfully' do
      it 'adds a friend successfully' do
        post :add_friend, params: { id: member.id, friend_id: friend.id }, format: :json
        expect(response).to have_http_status(:ok)
        expect(member.friends).to include(friend)
      end
    end

    it 'returns error if friend is already added' do
      member.add_friend(friend)
      post :add_friend, params: { id: member.id, friend_id: friend.id }, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body).to eq({ 'error' => 'Friend is already added' })
    end

    it 'returns error if friend id is invalid' do
      post :add_friend, params: { id: member.id, friend_id: 123 }, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #find_people_you_may_know' do
    context 'when there are people with similar interests' do
      let(:member) { create(:member) }
      let(:friend1) { create(:member) }
      let(:friend2) { create(:member) }
      let(:friend3) { create(:member) }

      before do
        create(:heading, content_value: 'ruby', member:)
        create(:heading, content_value: 'rails', member:)
        create(:heading, content_value: 'rails', member: friend1)
        create(:heading, content_value: 'ruby', member: friend2)
      end

      it 'returns a list of people you may know with the shortest path' do
        member.friends << friend1
        friend1.friends << friend2
        friend2.friends << friend3

        get :find_people_you_may_know, params: { id: member.id }
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body.size).to eq(2)
      end
    end

    context 'when there are no people with similar interests' do
      let(:no_sugg_member) { create(:member) }

      it 'returns an empty list if no people found' do
        get :find_people_you_may_know, params: { id: no_sugg_member.id }, format: :json
        expect(response).to have_http_status(:success)
        expect(response.parsed_body).to be_empty
      end
    end
  end
end
