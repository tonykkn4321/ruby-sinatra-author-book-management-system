require 'sinatra/json'

get '/authors' do
  json Author.includes(:books).all
end

post '/authors' do
  author = Author.new(params.slice('first_name', 'last_name'))
  if author.save
    status 201
    json author
  else
    status 400
    json error: author.errors.full_messages
  end
end

get '/authors/:id' do
  author = Author.includes(:books).find_by(id: params[:id])
  author ? json(author) : halt(404, json(error: 'Not found'))
end

put '/authors/:id' do
  author = Author.find_by(id: params[:id])
  halt(404, json(error: 'Not found')) unless author
  if author.update(params.slice('first_name', 'last_name'))
    json author
  else
    status 400
    json error: author.errors.full_messages
  end
end

patch '/authors/:id' do
  call env.merge("REQUEST_METHOD" => "PUT") # reuse PUT logic
end

delete '/authors/:id' do
  author = Author.find_by(id: params[:id])
  halt(404, json(error: 'Not found')) unless author
  author.destroy
  status 204
end
