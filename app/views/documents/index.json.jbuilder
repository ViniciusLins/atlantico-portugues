json.array!(@documents) do |document|
  json.extract! document, :id, :title, :author, :description, :keywords, :published_year, :publisher
  json.url document_url(document, format: :json)
end
