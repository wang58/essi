require 'spec_helper'
require 'rails_helper'

describe BagWorkJob do
  context "with uploaded files left in a dropbox" do
    before(:all) do
      @identifier = 'finished_work'
      @bags_path = Rails.root.join('tmp', 'bags' )
      dropbox_path = Rails.root.join('spec', 'fixtures', 'bagit', @identifier).to_s
      # Create a new bag by calling perform on described_class
      described_class.perform_now(@identifier, dropbox_path, @bags_path)
    end
    after(:all) do
      FileUtils.remove_dir(File.join(@bags_path, @identifier))
    end
    it "created a bag based on an identifier" do
      # Open newly created bag for validation
      bag = BagIt::Bag.new File.join(@bags_path, @identifier)
      expect(bag.valid?).to be_truthy
    end
    it "created a data directory with copies of files" do
      # Open newly created bag for validation
      bag = BagIt::Bag.new File.join(@bags_path, @identifier)
      # TODO Inspect bag for files from dropbox
    end
    it "created a bag with correct info" do
      # Open newly created bag for validation
      bag = BagIt::Bag.new File.join(@bags_path, @identifier)
      # TODO Inspect bag for files from dropbox
      # expect(@bag.bag_info.keys).to include("Custom-data")
    end
  end
end
