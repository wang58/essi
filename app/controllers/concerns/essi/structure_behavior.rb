module ESSI
  module StructureBehavior
    def structure
      parent_presenter
      @members = presenter.member_presenters
      @logical_order = presenter.logical_order_object
    end

    def save_structure
      structure = { "label": params["label"], "nodes": params["nodes"] }
      if curation_concern.lock?
        head 423
      else
        SaveStructureJob.perform_later(curation_concern, structure.to_json)
        head 200
      end
    end
  end
end

