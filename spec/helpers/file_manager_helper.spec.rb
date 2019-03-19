require 'rails_helper'

describe FileManagerHelper do
  let(:file_set) { FactoryBot.create(:file_set) }
  describe '#ocr_check(:id)' do
    context 'when fileset has extracted text' do
      it 'returns a checkmark' do
        expect(helper.ocr_check(file_set.id)).to eq('NO')
      end
    end
    context 'when fileset does not have extracted text' do
      it 'returns an x mark' do
        allow(file_set).to receive(:extracted_text) { 'Something' }
        expect(helper.ocr_check(file_set.id)).to eq('YES')
      end
    end
  end
end
