require 'base64'

module Concourse
  module ContentTypes
    APPLICATION_WWW_FORM_URLENCODED = 'application/x-www-form-urlencoded'
  end

  module Authorization
    def self.bearer(token)
      "Bearer #{token}"
    end

    def self.basic(username, password)
      "Basic #{Base64.encode64("#{username}:#{password}")}"
    end
  end

  module HeaderNames
    def self.content_type
      "Content-Type"
    end
    
    def self.authorization
      "Authorization"
    end

    def self.date
      "Date"
    end
  end

  module Headers
    def self.content_type(content_type)
      {Concourse::HeaderNames.content_type => content_type}
    end

    def self.authorization(authorization)
      {Concourse::HeaderNames.authorization => authorization}
    end
  end
end