module Catorax
  module BibRecordMetadata
    extend ActiveSupport::Concern

    included do
      # Add properties that would only be appropriate for use in objects of the BibRecord Work Type
      property :bib_editor, predicate: RDF::Vocab::BIBO.editor
      property :bib_article, predicate: RDF::Vocab::BIBO.Article
    end
  end
end
