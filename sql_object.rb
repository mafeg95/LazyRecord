require_relative './lib/db_connection'
require_relative './lib/associatable'
require_relative './lib/searchable'
require 'active_support/inflector'
require 'byebug'

class SQLObject
  extend Searchable
  extend Associatable

  def initialize(params = {})
    params.each do |column_name, value|
      symbol = column_name.to_sym
      raise "unknown attribute '#{column_name}'" unless self.class.columns.include?(symbol)
      self.send("#{column_name}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |attribute_key|
      self.send(attribute_key)
    end
  end

  def self.columns
    return @columns unless @columns.nil?
    query = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    @columns = query.first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |column_name|
      define_method(column_name) {attributes[column_name]}

      define_method("#{column_name}=") do |value|
        attributes[column_name] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    letters = "#{self}".split("")
    new_name = []
    letters.each do |letter|
      if (letter == letter.upcase)
        new_name.push("_")
        new_name.push(letter.downcase)
      else
        new_name.push(letter)
      end
    end
    new_name.shift
    new_name.push("s")
    @table_name = new_name.join("")
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    self.parse_all(results)
  end

  def self.parse_all(results)
    results.map do |result|
      self.new(result)
    end
  end

  def self.find(id)
    item = DBConnection.execute(<<-SQL, id)
      SELECT
       *
      FROM
        #{self.table_name}
      WHERE
        id = ?
    SQL
    item.empty? ? nil : self.parse_all(item)[0]
  end

  def insert
    col_names = self.class.columns.join(", ")
    question_marks = (["?"]*(self.class.columns.length)).join(", ")
    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_line = self.class.columns.map{|column_name| "#{column_name} = ?"}
    set_line_joined = set_line.join(", ")
    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line_joined}
      WHERE
        id = ?
    SQL

  end

  def save
    id.nil? ? self.insert : self.update
  end
end
