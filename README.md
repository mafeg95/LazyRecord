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

```ruby
Dog.all # returns an array of dogs
human1 = Human.find(1) # returns #<Human:0x00007fd5e72e0850 @attributes={:id=>1, :fname=>"Lily", :lname=>"Andrews"}>
human1.dogs # returns an array of dogs belonging to the human

bone_toy = Toy.where(name: 'Bone').first # returns #<Toy:0x00007fd5e8af99a0 
                                         #      @attributes={:id=>1, :name=>"Bone", :dog_id=>4}>
bone_toy.dog # returns #<Dog:0x00007fd5e8a9c278 @attributes={:id=>4, :name=>"Charlie", :owner_id=>3}>

brownie = Dog.new(name: 'Brownie', owner_id: 2) # returns => #<Dog:0x00007fd5e7839ae0 
                                                #      @attributes={:name=>"Brownie", :owner_id=>2}>
brownie.save # saves the dog, returns the dog id (7)
Dog.all.last # returns #<Dog:0x00007fd5e8a64ff8 @attributes={:id=>7, :name=>"Brownie", :owner_id=>2}>

thomas = Human.where(fname: 'Thomas').first # returns #<Human:0x00007fd5e7318250 
                                            #      @attributes={:id=>2, :fname=>"Thomas", :lname=>"Smith"}>
thomas.Name = 'not Thomas' # returns 'not Thomas'
thomas.update # returns 0
Human.find(2) # returns #<Human:0x00007fd5e7318250 
              #      @attributes={:id=>2, :fname=>"not Thomas", :lname=>"Smith"}>
```

## Next Steps

* Create the posibility to have `has_many_through` relations
* Create the posibility to prevent n+1 queries
* Create the posibility to select specific fields instead of selecting every field
