json.array!(@colors) do |color|
  json.extract! color, :id, :name, :score
  json.url color_url(color, format: :json)
end
