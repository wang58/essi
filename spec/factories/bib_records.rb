FactoryBot.define do
  factory :bib_record do
    title { ["Test title"] }
    # source_metadata_identifier "1234567"
    rights_statement { ["http://rightsstatements.org/vocab/NKC/1.0/"] }
    description { ["Description of a bibliographic record"] }
    visibility { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
    state { "complete" }

    transient do
      user { FactoryBot.create(:user) }
    end

    after(:build) do |work, evaluator|
      work.apply_depositor_metadata(evaluator.user.user_key)
    end
  end
end
