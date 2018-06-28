RSpec.shared_examples "MARC Relators" do
  it "includes extended MARC Relator metadata" do
    # Comes from including Catorax::ExtendedMetadata
    # Test a small subset of the properties available.
    expect(subject).to respond_to(:arranger)
    expect(subject).to respond_to(:author)
    expect(subject).to respond_to(:dubious_author)
  end
end

RSpec.shared_examples "Image Properties" do
  it "includes extended Image metadata" do
    # Comes from including Catorax::ImageMetadata
    # Test a small subset of the properties available.
    expect(subject).to respond_to(:digital_specifications)
  end
end