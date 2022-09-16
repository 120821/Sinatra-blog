require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'postgresql', database: 'datasetter_development')

class User < ActiveRecord::Base
end

# Create a new user object then save it to store in database
new_user = User.new(name: 'Dano')
puts "=== befor save user: "
puts new_user.inspect
new_user.save
puts "=== after save user: "
puts new_user.inspect
puts "=== after save user.all.size: "
puts User.all.size

User.new { |u|
    u.name = 'NanoDano'
}.save
puts "=== after save user.all.size: "
puts User.all.size


# Create and save in one step with `.create()`
User.create(name: 'John Leon')
puts "=== after save user.all.size: "
puts User.all.size
