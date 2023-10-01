json.extract! @book, :id, :title, :publication_year
json.genre do
  json.id @book.genre.id
  json.name @book.genre.name
end
json.author do
  json.id @book.author.id
  json.name @book.author.name
end
