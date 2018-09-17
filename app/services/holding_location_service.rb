module HoldingLocationService
  mattr_accessor :authority
  self.authority = Qa::Authorities::Local.subauthority_for('holding_locations')

  def self.select_options
    authority.all.map { |element| [element['label'], element['id']] }.sort
  end

  def self.select_all_options
    authority.all.map do |element|
      [element[:label], element[:id]]
    end
  end

  def self.find(id)
    authority.find(id)
  end
end
