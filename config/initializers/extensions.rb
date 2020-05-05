Rails.application.config.after_initialize do
  # active fedora node cache initialization
  ActiveFedora::Orders::OrderedList.prepend Extensions::ActiveFedora::Orders::OrderedList::InitializeNodeCache

  # extracted text support
  Hyrax::DownloadsController.prepend Extensions::Hyrax::DownloadsController::ExtractedText
  Hyrax::FileSetPresenter.include Extensions::Hyrax::FileSetPresenter::ExtractedText

  # viewing hint support
  IIIFManifest::ManifestBuilder::ImageBuilder.include Extensions::IIIFManifest::ManifestBuilder::ImageBuilder::ViewingHint
  Hyrax::Forms::FileManagerForm.include Extensions::Hyrax::Forms::FileManagerForm::ViewingMetadata
  Hyrax::FileSetPresenter.include Extensions::Hyrax::FileSetPresenter::ViewingHint

  # TODO: determine if needed?
  # iiif manifest support
  Hyrax::WorkShowPresenter.prepend Extensions::Hyrax::WorkShowPresenter::ManifestMetadata

  # add campus logo information when available.
  Hyrax::CollectionPresenter.prepend Extensions::Hyrax::CollectionPresenter::CampusLogo
  Hyrax::WorkShowPresenter.prepend Extensions::Hyrax::WorkShowPresenter::CampusLogo
  Hyrax::FileSetPresenter.prepend Extensions::Hyrax::FileSetPresenter::CampusLogo

  # add collection banner to works and file sets.
  Hyrax::FileSetPresenter.include Extensions::Hyrax::FileSetPresenter::CollectionBanner
  Hyrax::WorkShowPresenter.include Extensions::Hyrax::WorkShowPresenter::CollectionBanner

  # Use FileSet to store and display collection banner/logo image
  Hyrax::Forms::CollectionForm.prepend Extensions::Hyrax::Forms::CollectionForm::FileSetBackedBranding
  Hyrax::CollectionPresenter.prepend Extensions::Hyrax::CollectionPresenter::FileSetBackedBranding
  Hyrax::Dashboard::CollectionsController.prepend Extensions::Hyrax::Dashboard::CollectionsController::FileSetBackedBranding
end

# primary fields support
Hyrax::Forms::WorkForm.class_eval { include Extensions::Hyrax::Forms::WorkForm::PrimaryFields }
