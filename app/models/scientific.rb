# Generated via
#  `rails generate hyrax:work Scientific`
class Scientific < ActiveFedora::Base
  include Catorax::ScientificBehavior
  include ::Hyrax::WorkBehavior

  self.indexer = ScientificIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

 # Include extended metadata common to most Work Types
  include Catorax::ExtendedMetadata

  # This model includes metadata properties specific to the Scientific Work Type
  include Catorax::ScientificMetadata

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
