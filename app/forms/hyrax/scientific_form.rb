# Generated via
#  `rails generate hyrax:work Scientific`
module Hyrax
  # Generated form for Scientific
  class ScientificForm < Hyrax::Forms::WorkForm
    self.model_class = ::Scientific
    self.terms += [:resource_type]
    fields = WorkTypeService.fields_for model_name.name
    fields.each do |field|
      self.terms += [field[0]]
    end
    include ESSI::ScientificFormBehavior
  end
end
