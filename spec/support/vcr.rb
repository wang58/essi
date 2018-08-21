require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.default_cassette_options = { record: :once }
  c.hook_into :webmock
end
