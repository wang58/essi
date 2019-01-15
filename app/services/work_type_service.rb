module WorkTypeService
  def self.fields_for(work_type)
    Settings.work_types.to_hash[work_type.to_sym][:fields]
  end
end
