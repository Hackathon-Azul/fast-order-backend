json.categories do
    json.array! @categories, :id, :title
  end