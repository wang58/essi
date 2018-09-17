class HoldingLocationAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  def initialize(value, options = {})
    super(:holding_location, value, options)
  end

  def value_html
    Array(values).map do |value|
      location_string(HoldingLocationService.find(value))
    end.join("")
  end

  private

    def attribute_value_to_html(value)
      loc = HoldingLocationService.find(value)
      li_value location_string(loc)
    end

    def location_string(loc)
      return unless loc
      contact_string = safe_join(['Contact at ',
                                  content_tag(:a,
                                              loc.fetch('contact_email'),
                                              href: "mailto:#{loc.fetch('contact_email')}"),
                                  ', ',
                                  content_tag(:a,
                                              loc.fetch('phone_number'),
                                              href: "tel:#{loc.fetch('phone_number')}")])
      safe_join([loc.fetch('term'), loc.fetch('address'), contact_string], tag(:br))
    end
end
