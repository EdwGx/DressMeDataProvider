json.array!(@variables) do |variable|
  json.extract! variable, :id, :name, :value
  json.url variable_url(variable, format: :json)
end
