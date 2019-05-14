module FileSetPresenterAddViewingHints
  delegate :viewing_hint, to: :solr_document
end

Hyrax::FileSetPresenter.class_eval do
  prepend FileSetPresenterAddViewingHints
end

module FileSetEditFormAddViewingHints
  def self.included(base)
    base.class_eval do
      self.terms += [:viewing_hint]
    end
  end
end

Hyrax::Forms::FileSetEditForm.class_eval do
  include FileSetEditFormAddViewingHints
end

module ImageBuilderAddViewingHints
  def apply(canvas)
    annotation['on'] = canvas['@id']
    canvas['width'] = annotation.resource['width']
    canvas['height'] = annotation.resource['height']
    canvas['viewingHint'] = canvas_viewing_hint(canvas)
    canvas.images += [annotation]
  end

  def canvas_viewing_hint(canvas)
    id = canvas['@id'].split('/')[-1]
    FileSet.find(id).viewing_hint
  end
end

IIIFManifest::ManifestBuilder::ImageBuilder.class_eval do
  prepend ImageBuilderAddViewingHints
end
