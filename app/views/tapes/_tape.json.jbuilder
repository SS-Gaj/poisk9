json.extract! tape, :id, :tp_site, :tp_date, :tp_article, :tp_url, :tp_status, :tp_tag, :tp_comments, :created_at, :updated_at
json.url tape_url(tape, format: :json)
