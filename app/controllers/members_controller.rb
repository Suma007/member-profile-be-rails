# frozen_string_literal: true

class MembersController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  before_action :set_member, only: %i[show find_people_you_may_know add_friend]

  # GET /members or /members.json
  def index
    @members = Member.includes(:headings, :friends).all
    render json: @members
  end

  # GET /members/1 or /members/1.json
  def show
    @member = Member.includes(:headings, :friends).find(params[:id])
    render json: @member
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # POST /members or /members.json
  def create
    @member = Member.new(member_params)
    if @member.save
      log_in @member
      FetchHeadingsFromUrlJob.perform_later(@member)
      render json: 'Member added successfully', status: :created
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  def add_friend
    friend = Member.find_by(id: params[:friend_id])

    if friend && @member.add_friend(friend) && friend.add_friend(@member)
      render json: 'Friend added successfully', status: :ok
    else
      render json: { error: @member.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def find_people_you_may_know
    queries = @member.headings.pluck(:content_value)
    search_results = []

    queries.each do |query|
      search_result = Member.joins(:headings)
                            .where.not(id: @member.id)
                            .distinct
                            .where('content_value LIKE ?', "%#{query}%")

      search_result.each do |result|
        shortest_path = find_shortest_path(@member, result)
        search_results << { member: result, shortest_path: shortest_path } # rubocop:disable Style/HashSyntax
      end
    end

    if search_results.empty?
      render json: [], status: :ok
    else
      render json: search_results
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def member_params
    params.require(:member).permit(:name, :website_url, :friend_id, :password, :passwordConfirmation)
  end

  # using BFS here to find the shortest path between two friends
  def find_shortest_path(source, target)
    visited = {}
    queue = [[source, []]]

    until queue.empty?
      current, path = queue.shift
      return path + [current] if current.id == target.id

      next if visited[current.id]

      visited[current.id] = true
      current.friends.each do |friend|
        queue.push([friend, path + [current]])
      end
    end
    nil
  end
end
