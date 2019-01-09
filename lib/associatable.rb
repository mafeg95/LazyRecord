require_relative 'belongs_to_options'
require_relative 'has_many_options'

module Associatable

  def has_one_through(name, through_name, source_name)
    through_options = self.assoc_options[through_name]
    define_method(name) do
      source_options = through_options.model_class.assoc_options[source_name]
      key_value = self.send(source_options.primary_key)
      house = source_options.model_class.where(source_options.primary_key => key_value)[0]

    end
  end

  def belongs_to(name, options = {})
    self.assoc_options[name] = BelongsToOptions.new(name, options)
    define_method(name) do
      options = self.class.assoc_options[name]
      foreign_key_value = self.send(options.foreign_key)
      options.model_class.where(options.primary_key => foreign_key_value).first
    end
  end

  def has_many(name, options = {})
    self.assoc_options[name] = HasManyOptions.new(name, self.name, options)
    define_method(name) do
      options = self.class.assoc_options[name]
      primary_key_value = self.send(options.primary_key)
      options.model_class.where(options.foreign_key => primary_key_value)
    end
  end

  def assoc_options
    @assoc_options ||= {}
    @assoc_options
  end
end
