require_relative 'sql_object.rb'
DBConnection.reset

class Human < SQLObject
  has_many :dogs,
    primary_key: :id,
    foreign_key: :owner_id,
    class_name: :Dog
  finalize!
end

class Toy < SQLObject
  belongs_to :dog,
    primary_key: :id,
    foreign_key: :dog_id,
    class_name: :Dog
  finalize!
end

class Dog < SQLObject
  belongs_to :human,
    primary_key: :id,
    foreign_key: :owner_id,
    class_name: :Human

  has_many :toys,
    primary_key: :id,
    foreign_key: :dog_id,
    class_name: :Toy
  finalize!
end
