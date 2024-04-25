Elasticsearch::Model.client = Elasticsearch::Client.new host: 'elasticsearch', user: 'elastic', password: 'password', port: 9200, scheme: 'https', ssl: false do |faraday|
faraday.adapter Faraday.default_adapter
faraday.ssl.verify = false
end
