require 'rails_helper'

RSpec.describe "hyrax/paged_resources/structure.html.erb", type: :view do
  let(:logical_order) do
    WithProxyForObject::Factory.new(members).new(params)
  end
  let(:params) do
    {
      nodes: [
        {
          label: "Chapter 1",
          nodes: [
            {
              proxy: "a"
            }
          ]
        }
      ]
    }
  end
  let(:members) do
    [
      build_file_set(id: "a", to_s: "banana"),
      build_file_set(id: "b", to_s: "banana")
    ]
  end
  let(:paged_resource) {
    Hyrax::PagedResourcePresenter.new(
      SolrDocument.new(PagedResource.new(id: "test").to_solr), nil
    )
  }

  def build_file_set(id:, to_s:)
    endpoint = IIIFManifest::IIIFEndpoint.new('info_url', profile: Hyrax.config.iiif_image_compliance_level_uri)
    display_image = IIIFManifest::DisplayImage.new('display_url', width: 640, height: 480, iiif_endpoint: endpoint)
    instance_double(Hyrax::FileSetPresenter, id: id, display_image: display_image)
  end

  before do
    assign(:logical_order, logical_order)
    assign(:presenter, paged_resource)
    render
  end
  it "renders a li per node" do
    expect(rendered).to have_selector("li", count: 5)
  end
  it "renders a ul per order" do
    expect(rendered).to have_selector("ul", count: 3)
  end
  it "renders labels of chapters" do
    expect(rendered).to have_selector("input[value='Chapter 1']")
  end
  it "renders proxy nodes" do
    expect(rendered).to have_selector("li[data-proxy='a']")
  end
  it "renders unstructured nodes" do
    expect(rendered).to have_selector("li[data-proxy='b']")
  end
  pending "when given a multi volume work" do
    let(:paged_resource) {
      Hyrax::MultiVolumeWorkPresenter.new(
        SolrDocument.new(MultiVolumeWork.new(id: "test").to_solr), nil
      )
    }

    it "renders" do
      expect(rendered).to have_selector("li", count: 5)
      expect(rendered).to have_selector(
        "*[data-class-name='multi_volume_works']"
      )
    end
  end
end
