module ESSI
  module FileSetMetadata
    extend ActiveSupport::Concern

    included do
      # Add properties appropriate for use in file set objects
      property :viewing_hint, predicate: ::RDF::Vocab::IIIF.viewingHint, multiple: false
    end
  end
end
