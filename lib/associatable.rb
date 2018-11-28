require_relative 'searchable'
require_relative 'associatable'
require 'active_support/inflector'
require 'byebug'

class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    default = {foreign_key: "#{name}_id".to_sym, class_name: name.to_s.camelcase, primary_key: :id  }
    default.keys.each do |k|
      self.send("#{k}=", options[k] || default[k])
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    default = {foreign_key: "#{self_class_name.underscore}_id".to_sym, class_name: name.to_s.singularize.camelcase, primary_key: :id}

    default.keys.each do |k|
      self.send("#{k}=", options[k] || default[k])
    end
  end
end

class SQLObject
  extend Associatable
end
