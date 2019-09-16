# Generated via
#  `rails generate hyrax:work PagedResource`
require 'rails_helper'

RSpec.describe PagedResource do

  include_examples "MARC Relators"
  include_examples "PagedResource Properties"
  include_examples "ExtraLockable Behaviors" do
    let(:curation_concern) { FactoryBot.create(:paged_resource) }
  end
end
