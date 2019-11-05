require "json"
require "http/client"

module SpamWatch
  class Client

    @token : String

    @self_token : Token?

    property host : String

    def initialize(@token : String, @host : String = "https://api.spamwat.ch")
      @self_token = get_self
    end

    def get_tokens
      json = request("get", "/tokens")
      Array(Token).from_json(json)
    end

    def create_token(user_id, permission : Permission)
      json = request("post", "/tokens", {"id" => user_id, "permission" => permission})
      Token.from_json(json)
    end

    def get_self
      json = request("get", "/tokens/self")
      Token.from_json(json)
    end

    def delete_token(token_id)
      request("delete", "/tokens/#{token_id}")
      true
    end

    def get_bans
      json = request("get", "/banlist")
      Array(Ban).from_json(json)
    end

    def add_ban(user_id, reason)
      request("post", "/banlist", {"id" => user_id, "reason" => reason})
    end

    def add_bans(bans : Array(Ban))
      data = bans.map { |ban| {"id" => ban.id, "reason" => ban.reason}}
      request("post", "/banlist", data)
    end

    def get_ban(user_id)
      json = request("get", "/banlist/#{user_id}")
      Ban.from_json(json)
    rescue ex
      nil
    end

    def delete_ban(user_id)
      request("delete", "/banlist/#{user_id}")
    end

    private def self_token
      @self_token ||= get_self
    end

    private def request(method, path, params : Hash? | Array? = nil)
      path = File.join(@host, path)
      headers = HTTP::Headers{"Authorization" => "Bearer #{@token}"}

      response = HTTP::Client.exec(method.upcase, path, headers: headers, body: params.to_json)

      handle_errors(response)
      response.body
    end

    private def handle_errors(response)
      case response.status_code
      when 200, 201, 204
        # Do nothing
      when 401
        raise Error::Unauthorized.new("Make sure your token is correct")
      when 403
        raise Error::Forbidden.new(self_token)
      when 404
        raise Error::NotFound.new
      else
        raise Exception.new(response.body)
      end
    end
  end
end
