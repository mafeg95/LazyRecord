require_relative 'db_connection'
require 'byebug'

module Searchable
  def where(params)
    where_line = params.keys.map{|key| "#{key} = ?"}
    where_line_joined = where_line.join(" AND ")
    values_where = params.values
    items = DBConnection.execute(<<-SQL, *values_where)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{where_line_joined}
    SQL
    items.map{|item| self.new(item)}
  end
end
