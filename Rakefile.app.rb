#require 'standalone_migrations'
#StandaloneMigrations::Tasks.load_tasks
# From https://gist.github.com/Rhoxio/ee9a855088c53d447f2eb888bd9d09a4
require "active_record"
  require "fileutils"
  begin
    require 'dotenv/load'
  rescue LoadError
  end

FileUtils.mkdir_p "db/migrate"

namespace :db do
  include ActiveRecord::Tasks

  def db_config
    connection.db_config
  end

  def connection
    puts "Database url #{ENV['DATABASE_URL']}"

    @connection ||= ActiveRecord::Base.establish_connection
  end

  desc "Create the database"
  task :create do
    ActiveRecord::Tasks::DatabaseTasks.create db_config
  end


  desc "Migrate the database"
  task :migrate => [:create] do
    connection
    ActiveRecord::MigrationContext.new( 'db/migrate' ).migrate
    Rake::Task["db:schema"].invoke
  end

  desc "Drop the database"
  task :drop do
    connection
    ActiveRecord::Tasks::DatabaseTasks.drop db_config
  end

  desc "Reset the database"
  task :reset => [:drop, :create, :migrate]

  desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
  task :schema do
    ActiveRecord::Tasks::DatabaseTasks.db_dir = './db'
    ActiveRecord::Tasks::DatabaseTasks.dump_schema( db_config )
  end
end

namespace :g do
  desc "Generate migration"
  task :migration do
    name = ARGV[1] || raise("Specify name: rake g:migration your_migration")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<-EOF
  class #{migration_class} < ActiveRecord::Migration[6.0]
    def self.up
    end

    def self.down
    end
  end
      EOF
    end

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end
