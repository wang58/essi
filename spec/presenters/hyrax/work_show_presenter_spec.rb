require 'rails_helper'

RSpec.describe Hyrax::WorkShowPresenter do

  subject { described_class.new(double, double) }

  context "When initialized" do
    it "collection method is available" do
      expect(subject).to respond_to(:collection)
    end
  end
end
