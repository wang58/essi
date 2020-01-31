# Makes campus logo available to Collections, Works, and FileSets.
module Extensions
  module Hyrax
    module FileSetPresenter
      module CampusLogo
        def campus_logo
          return parent.admin_set.first if defined? parent.admin_set
        end
      end
    end
  end
end
