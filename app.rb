require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'postgresql', database: 'datasetter_development')

class User < ActiveRecord::Base
end

class Account < ActiveRecord::Base
end

class CreateAccountTable < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |table|
      table.string :first_name
      table.string :last_name
      table.timestamps null: false
    end
  end
end

class Manager < ActiveRecord::Base
end

class CreateManagerTable < ActiveRecord::Migration[5.2]
  def change
    create_table :managers do |table|
      table.string :first_name
      table.string :last_name
      table.timestamps null: false
    end
  end
end

# Create the table
CreateManagerTable.migrate(:up)

(1..10000).each do |i|
  Manager.create first_name: "jim", last_name: "#{('A'..'Z').to_a.shuffle[0,5].join}"
  puts Manager.all.size
end

(1..10000).each do |i|
  Manager.create last_name: "jim", first_name: "#{('A'..'Z').to_a.shuffle[0,5].join}"
  puts Manager.all.size
end

(1..80000).each do |i|
  Manager.create first_name: "#{('A'..'Z').to_a.shuffle[0,5].join}", last_name: "#{('A'..'Z').to_a.shuffle[0,5].join}"
  puts Manager.all.size
end
#80000.times do |i|
#end
# Drop the table
#CreateAccountTable migrate(:down)
# Create the table
#CreateAccountTable.migrate(:up)

#(1..10000).each do |i|
#  Account.create first_name: "jim", last_name: "#{('A'..'Z').to_a.shuffle[0,5].join}"
#  puts Account.all.size
#end

#(1..10000).each do |i|
#  Account.create last_name: "jim", first_name: "#{('A'..'Z').to_a.shuffle[0,5].join}"
#  puts Account.all.size
#end

#(1..80000).each do |i|
#  Account.create first_name: "#{('A'..'Z').to_a.shuffle[0,5].join}", last_name: "#{('A'..'Z').to_a.shuffle[0,5].join}"
#  puts Account.all.size
#end
#80000.times do |i|
#end
# Drop the table
#CreateAccountTable migrate(:down)

#User.columns.each { |column|
#  puts column.name
#  puts column.type
#}
## Create a new user object then save it to store in database
#new_user = User.new(name: 'Dano')
#puts "=== befor save user: "
#puts new_user.inspect
#new_user.save
#puts "=== after save user: "
#puts new_user.inspect
#puts "=== after save user.all.size: "
#puts User.all.size

#User.new { |u|
#  u.name = 'NanoDano'
#}.save
#puts "=== after save user.all.size: "
#puts User.all.size


## Create and save in one step with `.create()`
#User.create(name: 'John Leon')
#puts "=== after save user.all.size: "
#puts User.all.size

