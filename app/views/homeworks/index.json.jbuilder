json.array!(@homeworks) do |homework|
  json.extract! homework, :id, :name, :actual_phase, :upload
  json.url homework_url(homework, format: :json)
end
