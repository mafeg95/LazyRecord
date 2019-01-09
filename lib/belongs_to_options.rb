require_relative 'associatable_options'

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    default = {foreign_key: "#{name.downcase}_id".to_sym, class_name: name.to_s.camelcase, primary_key: :id  }
    default.keys.each do |k|
      self.send("#{k}=", options[k] || default[k])
    end
  end
end
