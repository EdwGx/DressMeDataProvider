json.array!(@articles) do |article|
  json.extract! article, :id, :position, :name, :score
  json.url article_url(article, format: :json)
end
