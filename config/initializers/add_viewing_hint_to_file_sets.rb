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
