module ESSI
  module Workflow
    module  CreateWorkBag
      def self.call(target:, **)
        # Creating a bag from source master files in a dropbox might take a
        # long time. Do this work in the background.
        return if target.source_metadata_identifier.nil?
        BagWorkJob.perform_later(target.source_metadata_identifier)
      end
    end
  end
end
