require 'rails_helper'

RSpec.describe FetchHeadingsFromUrlJob, type: :job do
  let(:member) { create(:member, website_url: 'http://example.com') }

  describe '#perform' do
    context 'when website content is successfully fetched and parsed' do
      before do
        allow(URI).to receive(:open).and_return(StringIO.new('<h1>Heading 1</h1>'))
      end

      it 'creates headings records' do
        expect { described_class.perform_now(member) }.to change { member.headings.count }.by(1)
      end
    end

    context 'when HTTP error occurs while fetching website content' do
      before do
        allow(URI).to receive(:open).and_raise(OpenURI::HTTPError.new('404 Not Found', nil))
      end

      it 'logs the error and does not create headings records' do
        expect(Rails.logger).to receive(:error).with(/HTTP error while fetching website content: 404 Not Found/)
        expect { described_class.perform_now(member) }.not_to change { member.headings.count }
      end
    end

    context 'when content retrieval is unsuccessful' do
      before do
        allow(URI).to receive(:open).and_return(nil)
      end

      it 'does not attempt to parse content and does not create headings records' do
        expect(Nokogiri::HTML).not_to receive(:parse)
        expect { described_class.perform_now(member) }.not_to change { member.headings.count }
      end
    end

    context 'when parsing the content' do
      before do
        allow(URI).to receive(:open).and_return(StringIO.new('<h1>Heading 1</h1><h2>Heading 2</h2>'))
      end

      it 'creates headings records with cleaned text' do
        described_class.perform_now(member)
        expect(member.headings.pluck(:content_value)).to match_array(['Heading 1', 'Heading 2'])
      end
    end
  end
end
