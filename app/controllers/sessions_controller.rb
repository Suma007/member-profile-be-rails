# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def new; end

  def create
    member = Member.find_by(name: params[:session][:name])
    if member&.authenticate(params[:session][:password])
      log_in member
      render json: { logged_in: true, member: MemberSerializer.new(member) }, status: :ok
    else
      render json: { logged_in: false }, status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    render json: { message: 'Logged out successfully' }, status: :ok
  end
end
