class HeadingsController < ApplicationController
  def search
    query = params[:query]
    headings = Heading.where('content_value ILIKE ?', "%#{query}%").includes(:member)
    results = headings.map { |h| { member_id: h.member.id, member_name: h.member.name, heading_content: h.content_value } }
    render json: results
  end
end
