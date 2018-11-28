require 'rails_helper'

describe ApplicationHelper do
  describe '#display_for(:role)' do
    let(:user) { FactoryBot.build(:admin) }
    let(:edit_role) { Role.where(name: 'editor').first_or_create }
    let(:admin_role) { Role.where(name: 'admin').first_or_create }
    before do
      assign(:user, user)
      assign(:edit_role, edit_role)
      assign(:admin_role, admin_role)
    end
    context 'when the current user has the role' do
      it 'displays the content' do
        allow(user).to receive(:roles) { [admin_role, edit_role] }
        allow(helper).to receive(:current_user).and_return(user)
        content = helper.display_for('admin') { 'content' }
        expect(content).to eq('content')
      end
    end
    context 'when the current user does not have the role' do
      it 'does not display content' do
        edit_role = Role.where(name: 'editor').first_or_create
        allow(user).to receive(:roles) { [edit_role] }
        allow(helper).to receive(:current_user).and_return(user)
        content = helper.display_for('admin') { 'content' }
        expect(content).to eq(nil)
      end
    end
  end
end
