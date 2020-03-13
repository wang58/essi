class BagWorkJob < ActiveJob::Base
  queue_as Hyrax.config.ingest_queue_name

  def perform(identifier, dropbox_path, bags_path)
    bag = BagIt::Bag.new File.join(bags_path, identifier)
    Dir.foreach(dropbox_path) do |filename|
      next if filename == '.' or filename == '..'
      Rails.logger.info "Adding {#filename} to {#bags_path} from " + File.join(dropbox_path, filename)
      bag.add_file(filename, File.join(dropbox_path, filename))
    end
    bag.manifest!(algo: 'sha256')
  end
end