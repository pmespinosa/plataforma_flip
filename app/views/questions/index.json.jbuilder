json.array!(@questions) do |question|
  json.extract! question, :id, :phase, :upload, :content
  json.url question_url(question, format: :json)
end
