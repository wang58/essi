# Generated via
#  `rails generate hyrax:work Scientific`
module Hyrax
  # Generated form for Scientific
  class ScientificForm < Hyrax::Forms::WorkForm
    self.model_class = ::Scientific
    self.terms += [:resource_type]
    fields =  Settings.work_types.to_hash['Scientific Work'.to_sym][:fields]
    fields.each do |field|
      self.terms += [field[0]]
    end
    include ESSI::ScientificFormBehavior
  end
end
