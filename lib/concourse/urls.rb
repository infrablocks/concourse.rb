module Concourse
  module Urls
    def self.api_url(concourse_url)
      "#{concourse_url}/api/v1"
    end

    def self.sky_token_url(concourse_url)
      "#{concourse_url}/sky/token"
    end

    def self.sky_issuer_token_url(concourse_url)
      "#{concourse_url}/sky/issuer/token"
    end

    def self.info_url(concourse_url)
      "#{api_url(concourse_url)}/info"
    end
  end
end
