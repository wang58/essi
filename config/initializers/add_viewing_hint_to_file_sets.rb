module FileSetPresenterAddViewingHints
  delegate :viewing_hint, to: :solr_document
end

Hyrax::FileSetPresenter.class_eval do
  prepend FileSetPresenterAddViewingHints
end

module FileSetEditFormAddViewingHints
  self.terms += [:viewing_hint]
end

Hyrax::FileSetEditForm.call_eval do
  prepend FileSetEditFormAddViewingHints
end
