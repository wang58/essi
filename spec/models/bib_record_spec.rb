# Generated via
#  `rails generate hyrax:work BibRecord`
require 'rails_helper'
require 'metadata_helper'

RSpec.describe BibRecord do

  include_examples "MARC Relators"
  include_examples "BibRecord Properties"
end
