require "json"

module SpamWatch
  enum Permission
    Root
    Admin
    User

    def from_json(json : JSON::PullParser)
      Permission.from_value(json.read_string)
    end

    def to_json(json : JSON::Builder)
      json.string(value)
    end
  end
end
