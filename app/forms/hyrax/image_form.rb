# Generated via
#  `rails generate hyrax:work Image`
module Hyrax
  # Generated form for Image
  class ImageForm < Hyrax::Forms::WorkForm
    self.model_class = ::Image
    self.terms += [:resource_type]
    include ESSI::ImageFormBehavior
    include ScoobySnacks::WorkFormBehavior
  end
end
