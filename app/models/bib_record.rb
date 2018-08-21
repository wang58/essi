# Generated via
#  `rails generate hyrax:work BibRecord`
class BibRecord < ActiveFedora::Base
  include Catorax::BibRecordBehavior
  include ::Hyrax::WorkBehavior

  self.indexer = BibRecordIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

 # Include extended metadata common to most Work Types
  include Catorax::ExtendedMetadata

  # This model includes metadata properties specific to the BibRecord Work Type
  include Catorax::BibRecordMetadata

  # Include properties for remote metadata lookup
  include Catorax::RemoteLookupMetadata

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
