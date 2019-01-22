module CreateDerivativesJobOverride

  # @param [FileSet] file_set
  # @param [String] file_id identifier for a Hydra::PCDM::File
  # @param [String, NilClass] filepath the cached file within the Hyrax.config.working_path
  def perform(file_set, file_id, filepath = nil)
    Rails.logger.info 'Create Derivatives Job Override Hit'
    super
  end
end

Hyrax::CreateDerivativesJob.class_eval do
  Rails.logger.info 'Create Derivatives Job Prepend Hit'
  prepend CreateDerivativesJobOverride
end
