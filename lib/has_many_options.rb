require_relative 'associatable_options'

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    default = {foreign_key: "#{self_class_name.underscore}_id".to_sym, class_name: name.to_s.singularize.camelcase, primary_key: :id}

    default.keys.each do |k|
      self.send("#{k}=", options[k] || default[k])
    end
  end
end
