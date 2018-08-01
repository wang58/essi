RSpec.shared_examples "structure persister" \
do |resource_symbol, presenter_factory|
  describe "when logged in" do

    let(:admin_set_id) { AdminSet.find_or_create_default_admin_set_id }
    let(:permission_template) { Hyrax::PermissionTemplate.find_or_create_by!(source_id: admin_set_id) }
    let(:workflow) { Sipity::Workflow.create!(active: true, name: 'test-workflow', permission_template: permission_template) }
    let(:user) { FactoryBot.create(:user) }
    describe "#structure" do


      let(:solr) { ActiveFedora.solr.conn }
      let(:resource) do
        r = FactoryBot.build(resource_symbol)
        allow(r).to receive(:id).and_return("1")
        allow(r.list_source).to receive(:id).and_return("3")
        r
      end
      let(:file_set) do
        f = FactoryBot.build(:file_set)
        allow(f).to receive(:id).and_return("2")
        f
      end

      before do
        # Create a single action that can be taken
        Sipity::WorkflowAction.create!(name: 'submit', workflow: workflow)

        # Grant the user access to deposit into the admin set.
        Hyrax::PermissionTemplateAccess.create!(
            permission_template_id: permission_template.id,
            agent_type: 'user',
            agent_id: user.user_key,
            access: 'deposit'
        )
        sign_in user
        resource.ordered_members << file_set
        solr.add file_set.to_solr.merge(ordered_by_ssim: [resource.id])
        solr.add resource.to_solr
        solr.add resource.list_source.to_solr
        solr.commit
      end

      it "sets @members" do
        get :structure, id: "1"

        expect(assigns(:members).map(&:id)).to eq ["2"]
      end
      it "sets @logical_order" do
        obj = instance_double("logical order object")
        allow_any_instance_of(presenter_factory) \
        .to receive(:logical_order_object).and_return(obj)
        get :structure, id: "1"

        expect(assigns(:logical_order)).to eq obj
      end
    end

    describe "#save_structure" do
      let(:resource) { FactoryBot.create(resource_symbol, user: user) }
      let(:file_set) { FactoryBot.create(:file_set, user: user) }
      #let(:user) { FactoryBot.create(:admin) }
      let(:nodes) do
        [
            {
                "label": "Chapter 1",
                "nodes": [
                    {
                        "proxy": file_set.id
                    }
                ]
            }
        ]
      end

      before do
        sign_in user
        resource.ordered_members << file_set
        resource.save
      end

      it "persists order" do
        post :save_structure, nodes: nodes, id: resource.id, label: "TOP!"

        expect(response.status).to eq 200
        expect(resource.reload.logical_order.order) \
        .to eq({ "label": "TOP!", "nodes": nodes }.with_indifferent_access)
      end
    end

  end
end
