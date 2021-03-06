# Generated via
#  `rails generate hyrax:work Image`
class ImageIndexer < Hyrax::WorkIndexer
  include ESSI::IndexesImageMetadata # Replaces IndexesBasicMetadata
  include ESSI::ImageIndexerBehavior
  include ESSI::IIIFThumbnailBehavior
  include ESSI::IndexesNumPages

  # Fetch remote labels for based_near. You can remove this if you don't want
  # this behavior
  include Hyrax::IndexesLinkedMetadata

  # Uncomment this block if you want to add custom indexing behavior:
  # def generate_solr_document
  #  super.tap do |solr_doc|
  #    solr_doc['my_custom_field_ssim'] = object.my_custom_property
  #  end
  # end
end
