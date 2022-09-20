class CreateRoles < ActiveRecord::Migration[6.0]
  def self.up
    create_table :roles do |t|
      t.string :name
      t.boolean :billable
    end
  end

  def self.down
    drop_table :roles
  end
end

