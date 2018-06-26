# Generated via
#  `rails generate hyrax:work PagedResource`
module Hyrax
  # Generated form for PagedResource
  class PagedResourceForm < Hyrax::Forms::WorkForm
    self.model_class = ::PagedResource
    self.terms += [:resource_type]
  end
end
