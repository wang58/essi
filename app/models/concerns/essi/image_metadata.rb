module ESSI
  module ImageMetadata
    extend ActiveSupport::Concern

    included do
      # Add properties that would only be appropriate for use in objects of the Image Work Type
      property :digital_specifications, predicate: RDF::Vocab::DC11.format
    end
  end
end
