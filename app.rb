require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv/load'

# Load database config based on RACK_ENV
set :environment, ENV['RACK_ENV'] || :development
set :database_file, 'config/database.yml'

# Require models
require_relative './models/author'
require_relative './models/book'

# Require routes
require_relative './routes/authors'
require_relative './routes/books'

# Auto-create tables if they don't exist
configure do
  ActiveRecord::Base.logger = Logger.new(STDOUT) if settings.development?

  unless ActiveRecord::Base.connection.table_exists?('authors') &&
         ActiveRecord::Base.connection.table_exists?('books')
    ActiveRecord::Schema.define do
      create_table :authors do |t|
        t.string :first_name
        t.string :last_name
      end

      create_table :books do |t|
        t.string  :title
        t.integer :year
        t.integer :author_id
      end
    end
    puts "✅ Tables created"
  end
end
