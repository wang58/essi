module FileManagerHelper
  def ocr_check(id)
    checkmark = "\u2705" # Green boxed checkmark
    crossmark = "\u274C" # Red crossmark

    return checkmark.encode('utf-8') if ::FileSet.find(id).extracted_text
    crossmark.encode('utf-8')
  end
end
