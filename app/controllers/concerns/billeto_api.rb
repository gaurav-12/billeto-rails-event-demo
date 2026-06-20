module BilletoApi
    BASE_URL = ENV['BILLETO_BASE_URL'].freeze
    ACCESS_KEY = ENV['ACCESS_KEY_ID'].freeze
    SECRET = ENV['SECRET_ACCESS_KEY'].freeze

    def sync_public_events
        response = HTTParty.get(BASE_URL + ENV['BILLETO_PUB_EVENTS_PATH'], headers: headers)
        response.body
        # TODO: Add error handling
        # TODO: Create event record for each fetched with duplicate check
    end

    private

    def headers
        {
            'Api-Keypair' => "#{ACCESS_KEY}:#{SECRET}",
            'accept' => 'application/json'
        }
    end
end