require 'sinatra/json'

get '/books' do
  json Book.all
end

post '/books' do
  book = Book.new(params.slice('title', 'year', 'author_id'))
  if book.save
    status 201
    json book
  else
    status 400
    json error: book.errors.full_messages
  end
end

get '/books/:id' do
  book = Book.find_by(id: params[:id])
  book ? json(book) : halt(404, json(error: 'Not found'))
end

put '/books/:id' do
  book = Book.find_by(id: params[:id])
  halt(404, json(error: 'Not found')) unless book
  if book.update(params.slice('title', 'year', 'author_id'))
    json book
  else
    status 400
    json error: book.errors.full_messages
  end
end

patch '/books/:id' do
  call env.merge("REQUEST_METHOD" => "PUT")
end

delete '/books/:id' do
  book = Book.find_by(id: params[:id])
  halt(404, json(error: 'Not found')) unless book
  book.destroy
  status 204
end
