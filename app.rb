require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv/load'

set :database_file, 'config/database.yml'

require_relative './models/author'
require_relative './models/book'
require_relative './routes/authors'
require_relative './routes/books'
