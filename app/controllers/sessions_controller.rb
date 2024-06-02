class SessionsController < ApplicationController
  def new
  end

  def create
    member = Member.find_by(name: params[:session][:name])
    if member && member.authenticate(params[:session][:password])
      log_in member
      render json: { message: "Logged in successfully",  member: MemberSerializer.new(member) }, status: :ok
    else
      render json: { message: "Invalid name/password combination" }, status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    render json: { message: "Logged out successfully" }, status: :ok
  end
end
