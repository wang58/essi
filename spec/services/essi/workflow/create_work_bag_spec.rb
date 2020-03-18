require 'spec_helper'
require 'rails_helper'

RSpec.describe ESSI::Workflow::CreateWorkBag do
  let(:work) { create(:generic_work) }
  let(:user) { create(:user) }
  let(:workflow_method) { described_class }

  describe ".call" do
    xit "triggers job to create a bag for work" do
      # TODO Not sure what to test for here quite yet
    end
  end
end
