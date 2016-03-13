json.array!(@clothes) do |clothe|
  json.extract! clothe, :id, :article_id, :color_id, :raw_description, :score
  json.url clothe_url(clothe, format: :json)
end
