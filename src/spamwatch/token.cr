require "json"
require "uuid"

module SpamWatch
  struct Token
    include JSON::Serializable

    getter id : Int64

    getter permission : SpamWatch::Permission

    getter token : String

    @[JSON::Field(key: "userid")]
    getter user_id : Int64
  end
end
