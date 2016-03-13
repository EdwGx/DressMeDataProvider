json.array!(@suggestions) do |suggestion|
  json.extract! suggestion, :id, :response
  json.url suggestion_url(suggestion, format: :json)
end
