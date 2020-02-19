require 'rails_helper'

RSpec.describe Hyrax::FileSetPresenter do
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
      sets = ['The Collection', 'Another Collection']
      @snake = 'the_collection'
      @title = 'The Title'
      @url = 'http://university.edu'
      work = double('WorkType', admin_set: sets)
      allow(subject).to receive(:parent).and_return(work)
    end

    it '.campus_logo returns configured values' do
      ESSI.config[:essi][:campus_logos][@snake] = { title: @title, url: @url }
      expect(subject.campus_logo).to include(@title)
      expect(subject.campus_logo).to include(@url)
    end
  end
end
