require 'spec_helper'
require 'rails_helper'

describe IngestYAMLJob do
  let(:paged_resource_yaml) { Rails.root.join('spec', 'fixtures', 'paged_resource.yml').to_s }
  let(:user) { FactoryBot.create(:user) }

  describe 'for a single PagedResource', :clean do
    it 'creates a PagedResource with logical structure' do
      expect(PagedResource.count.zero?).to be true
      described_class.perform_now(paged_resource_yaml, user)
      expect(PagedResource.last.logical_order.order).to be_present
    end
    it 'attaches a FileSet to the PagedResource' do
      expect(PagedResource.count.zero?).to be true
      described_class.perform_now(paged_resource_yaml, user)
      expect(PagedResource.last.file_sets.any?).to be true
    end
    it 'attaches a file to the created FileSet' do
      expect(IngestLocalFileJob).to receive(:perform_later)
      described_class.perform_now(paged_resource_yaml, user)
    end
  end
end
