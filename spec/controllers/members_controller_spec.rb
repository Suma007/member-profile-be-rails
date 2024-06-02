require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new member" do
        expect {
          post :create, params: { member: FactoryBot.attributes_for(:member) }
        }.to change(Member, :count).by(1)
        expect(Sidekiq::Worker.jobs.size).to eq(1)
      end

      it "redirects to new member" do

        post :create, params: { member: FactoryBot.attributes_for(:member) }
        expect(response).to redirect_to(member_url(Member.last))
      end
    end

    context "with invalid attributes" do
      it "does not create a new member" do
        expect {
          post :create, params: { member: FactoryBot.attributes_for(:member, name: nil) }
        }.to_not change(Member, :count)
      end

      it "returns an unprocessable entity status" do
        post :create, params: { member: FactoryBot.attributes_for(:member, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
