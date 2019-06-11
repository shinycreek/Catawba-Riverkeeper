json.lake_levels @lake_levels do |ll|
  url = "https://lakes.duke-energy.com/index.html#/detail/#{ll.api_lake_id}/Detail"
  json.lake_name ll.lake_name
  json.level ll.level
  json.target ll.target
  json.news ll.news
  json.lake_url url
end
