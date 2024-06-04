# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class FetchHeadingsFromUrlJob < ApplicationJob
  queue_as :default

  def perform(member)
    content = fetch_website_content(member.website_url)
    return unless content

    doc = Nokogiri::HTML(content)
    (1..3).each do |level|
      doc.css("h#{level}").each do |heading|
        cleaned_heading = clean_text(heading.text)
        member.headings.create(level:, content_value: cleaned_heading)
      end
    end
  end

  def clean_text(text)
    text.gsub(/\s+/, ' ').strip
  end

  def fetch_website_content(url)
    URI.open(url).read # rubocop:disable Security/Open
  rescue OpenURI::HTTPError => e
    Rails.logger.error "HTTP error while fetching website content: #{e.message}"
    nil
  rescue StandardError => e
    Rails.logger.error "Error while fetching website content: #{e.message}"
    nil
  end
end
