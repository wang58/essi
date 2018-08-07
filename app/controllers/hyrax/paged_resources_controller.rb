# Generated via
#  `rails generate hyrax:work PagedResource`
module Hyrax
  # Generated controller for PagedResource
  class PagedResourcesController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Catorax::PagedResourcesControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::PagedResource

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::PagedResourcePresenter

    def structure
      parent_presenter
      @members = presenter.member_presenters
      @logical_order = presenter.logical_order_object
    end
  end
end
