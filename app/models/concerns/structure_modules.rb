module StructureModules
  def self.included(base)
    base.class_eval do
      include ::StructuralMetadata
    end
    "Hyrax::#{base}Presenter".constantize.class_eval do
      include ESSI::PresentsStructure
    end
    "Hyrax::#{base.to_s.pluralize}Controller".constantize.class_eval do
      include ESSI::StructureBehavior
    end
  end
end
