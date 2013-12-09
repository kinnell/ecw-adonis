json.array!(@weighins) do |weighin|
  json.extract! weighin, :weight
  json.url weighin_url(weighin, format: :json)
end
