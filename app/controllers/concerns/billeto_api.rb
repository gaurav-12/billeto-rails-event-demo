module BilletoApi
    extend ActiveSupport::Concern

    BASE_URL = ENV["BILLETO_BASE_URL"].freeze
    ACCESS_KEY = ENV["ACCESS_KEY_ID"].freeze
    SECRET = ENV["SECRET_ACCESS_KEY"].freeze

    def sync_public_events
        # TODO: Add pagination logic to not always fetch same page from public events list
        response = HTTParty.get("#{BASE_URL}#{ENV['BILLETO_PUB_EVENTS_PATH']}", headers: headers)
        response_body = JSON.parse response.body

        if response_body.present? && response_body["object"].eql?("list")
            parse_events_list response_body["data"]
        else
            { message: "Something went wrong", success: false }
        end
      # TODO: Add error handling
    end

    private

    def headers
        {
            "Api-Keypair" => "#{ACCESS_KEY}:#{SECRET}",
            "accept" => "application/json"
        }
    end

    def parse_events_list(events_list)
        sync_report = { synced: 0, failed: 0, success: true }
        events_list.each do |event|
            begin
                save_event event
                sync_report[:synced] += 1
            rescue Exception => e # TODO: Handle specific errors
                Rails.logger.error "Failed #{event["id"]}: #{e.message}"
                debugger
                sync_report[:failed] += 1
            end
        end
        sync_report
    end

    def save_event(event)
        record = Event.new(
            billeto_id: event["id"],
            title: event["title"],
            description: event["description"],
            url: event["url"],
            image_link: event["image_lin"],
            available: event["availability"],
            organizer_name: event["organiser"]["name"],
            price: event["minimum_price"]["amount_in_cents"],
            currency: event["minimum_price"]["currency"],
            category: event["categorization"]["category_localized"],
            start_date: event["startdate"],
            end_date: event["enddate"],
            location: event["location"]["location_name"]
        )
        record.save!
    end
end
