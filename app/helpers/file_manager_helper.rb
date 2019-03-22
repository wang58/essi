module FileManagerHelper
  def ocr_check(id)
    return 'YES' if FileSet.find(id).extracted_text
    'NO'
  end
end
