# We use modify instead of define because the actual factory is defined in hyrax/spec/factories
FactoryBot.modify do
  factory :file_set, class: FileSet do

    transient do
      user { FactoryBot.create(:user) }
      content { nil }
    end

    after(:create) do |file, evaluator|
      if evaluator.content
        Hydra::Works::UploadFileToFileSet.call(file, evaluator.content)
      end
    end

    after(:build) do |file, evaluator|
      file.apply_depositor_metadata(evaluator.user.user_key)
    end
  end
end
