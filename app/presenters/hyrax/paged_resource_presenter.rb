# Generated via
#  `rails generate hyrax:work PagedResource`
module Hyrax
  class PagedResourcePresenter < Hyrax::WorkShowPresenter
    delegate :num_pages, :series, :viewing_direction, :viewing_hint,
             to: :solr_document

    def holding_location
      HoldingLocationAttributeRenderer.new(solr_document.holding_location).render_dl_row
    end

    # FIXME: delegate to solr_document?
    def logical_order
      @logical_order ||=
        begin
          JSON.parse(solr_document[Solrizer.solr_name("logical_order",
                                             :stored_searchable)].first)
        rescue StandardError
          {}
        end
    end

    def logical_order_object
      @logical_order_object ||=
          logical_order_factory.new(logical_order, nil, logical_order_factory)
    end

    def ranges
      Array.wrap(logical_order_object.to_manifest_range)
    end

    # Copied from Hyrax gem
    # IIIF metadata for inclusion in the manifest
    #  Called by the `iiif_manifest` gem to add metadata
    #
    # @return [Array] array of metadata hashes
    def manifest_metadata
      metadata = []
      Hyrax.config.iiif_metadata_fields.each do |field|
        next if send(field).blank?

        metadata << {
          'label' => I18n.t("simple_form.labels.defaults.#{field}", default: field.to_s.humanize),
          'value' => Array.wrap(send(field))
        }
      end
      metadata
    end

    private
      def logical_order_factory
        @logical_order_factory ||=
          WithProxyForObject::Factory.new(member_presenters)
      end
   end
 end
