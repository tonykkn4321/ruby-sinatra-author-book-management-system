# Project Structure:
sinatra-author-book-management-system/
├── config/
│   └── database.yml
├── models/
│   ├── author.rb
│   └── book.rb
├── routes/
│   ├── authors.rb
│   └── books.rb
├── app.rb
├── Rakefile    (for migrations)
├── Gemfile
└── .env

# Run this to auto-create tables:
bundle exec rake db:create
bundle exec rake db:migrate


# Run Your Application:
ruby app.rb