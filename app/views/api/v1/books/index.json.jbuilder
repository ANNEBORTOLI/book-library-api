json.array! @books do |book|
  json.id book.id
  json.title book.title
  json.publication_year book.publication_year
  json.genre do
    json.id book.genre.id
    json.name book.genre.name
  end
  json.author do
    json.id book.author.id
    json.name book.author.name
  end
end
