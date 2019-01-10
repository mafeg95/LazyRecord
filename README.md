# LazyRecord

LazyRecord is an object-relational mapper inspired by Active Record. It connects classes to relational database tables, establishing the basic framework to object oriented programing to work as an application.

## How to use:

1. Clone this repo
2. Run `bundle install` in the root directory to install the gems
3. Run `bundle exec pry` in the root directory to go in pry
4. Explore the ORM!

## Methods Available

* ::all
* ::table_name
* ::find(id)
* ::new()
* #save
* #update
* #attributes
* #attributes_values

## Sample Database Scheme

### Humans table

|column name   |data type   |details   |
|-----|-----|-----|
|id   |integer   |not null, primary key   |
|fname   |string    |not null   |
|lname   |string    |not null   |

### Dogs table

|column name   |data type   |details   |
|-----|-----|-----|
|id   |integer   |not null, primary key   |
|name   |string    |not null   |
|owner_id   |integer   |not null, unique, indexed   |

### Toys table

|column name   |data type   |details   |
|-----|-----|-----|
|id   |integer   |not null, primary key   |
|name   |string    |not null   |
|dog_id   |integer   |not null, unique, indexed   |

## Inspiration

`Dog.all # returns an array of dogs
 human1 = Human.find(1) # #<Human:0x00007fd5e72e0850 @attributes={:id=>1, :fname=>"Lily", :lname=>"Andrews"}>`

## Next Steps

* Searches the database for the queries requested

* Creates associations between different tables
