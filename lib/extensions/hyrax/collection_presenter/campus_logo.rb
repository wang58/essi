# Makes campus logo available to Collections, Works, and FileSets.
module Extensions
  module Hyrax
    module CollectionPresenter
      module CampusLogo
        def campus_logo
          return collection_type.title if defined? collection_type
        end
      end
    end
  end
end
