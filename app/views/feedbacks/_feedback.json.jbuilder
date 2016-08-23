json.extract! feedback, :id, :text, :tree_id, :created_at, :updated_at
json.url feedback_url(feedback, format: :json)