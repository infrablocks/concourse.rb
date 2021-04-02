# frozen_string_literal: true

module Build
  module ClientResponse
    def self.info(parameters = {})
      {
        version: '3.14.1',
        worker_version: '2.1',
        external_url: 'https://ci.example.com',
        cluster_name: 'CI Cluster'
      }.merge(parameters)
    end
  end
end
