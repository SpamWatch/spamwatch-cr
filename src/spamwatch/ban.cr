require "json"
require "uuid"

module SpamWatch
  struct Ban
    include JSON::Serializable

    getter id : Int64

    getter reason : String

    @[JSON::Field(key: "date", converter: Time::EpochConverter)]
    getter date : Time?

    def timestamp
      date.to_unix
    end
  end
end
