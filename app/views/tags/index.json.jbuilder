json.array!(@tags) do |tag|
  json.extract! tag, :id, :name, :score
  json.url tag_url(tag, format: :json)
end
