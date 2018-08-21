require 'rails_helper'

RSpec.describe Hyrax::BibRecordsController do
  include_examples("update metadata remotely", :bib_record)
end
