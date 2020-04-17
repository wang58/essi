module ESSI
  module PagedResourceBehavior
    extend ActiveSupport::Concern
    # Add behaviors that make this work type unique
    included do
      def ocr_searchable?
        return true if self.ocr_state == 'searchable'
        return false
      end
    end

    def to_solr(solr_doc = {})
      super.tap do |doc|
        doc[Solrizer.solr_name('ocr_searchable',
                               Solrizer::Descriptor.new(:boolean, :stored, :indexed))] = self.ocr_searchable?
      end
    end
  end
end
