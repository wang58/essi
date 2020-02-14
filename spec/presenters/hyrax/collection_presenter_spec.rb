require 'rails_helper'

RSpec.describe Hyrax::CollectionPresenter do
  subject { described_class.new(double, double) }

  context 'When initialized' do
    it '.campus_logo is available' do
      expect(subject).to respond_to(:campus_logo)
    end
  end

  context 'When collection matches configuration' do
    before do
      name = 'The Collection'
      @snake = 'the_collection'
      @title = 'The Title'
      @url = 'http://university.edu'
      collection = double('CollectionType', title: name)
      allow(subject).to receive(:collection_type).and_return(collection)
    end

    it '.campus_logo returns configured values' do
      ESSI.config[:essi][:campus_logos][@snake] = { title: @title, url: @url }
      expect(subject.campus_logo).to include(@title)
      expect(subject.campus_logo).to include(@url)
    end
  end
end
