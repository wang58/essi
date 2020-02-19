require 'rails_helper'

RSpec.describe Hyrax::WorkShowPresenter do
  subject { described_class.new(double, double) }

  context 'When initialized' do
    it '.collection is available' do
      expect(subject).to respond_to(:collection)
    end
    it '.campus_logo is available' do
      expect(subject).to respond_to(:campus_logo)
    end
  end

  context 'When admin_set matches configuration' do
    before do
      name = ['The Collection', 'Another Collection']
      @snake = 'the_collection'
      @title = 'The Title'
      @url = 'http://university.edu'
      allow(subject).to receive(:admin_set).and_return(name)
    end

    it '.campus_logo returns configured values' do
      ESSI.config[:essi][:campus_logos][@snake] = { title: @title, url: @url }
      expect(subject.campus_logo).to include(@title)
      expect(subject.campus_logo).to include(@url)
    end
  end
end
