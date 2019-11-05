module SpamWatch
  class Error < Exception
    class Unauthorized < Error; end

    class Forbidden < Error
      def initialize(token)
        super("Your token's permission level `#{token.permission}` is not high enough.")
      end
    end

    class NotFound < Error; end
  end
end
