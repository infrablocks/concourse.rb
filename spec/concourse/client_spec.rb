require 'spec_helper'

RSpec.describe Concourse::Client do
  context 'get_info' do
    it 'gets server info' do
      concourse_url = Build::Data.random_concourse_url

      client = Concourse::Client.new({
          url: concourse_url,
      })

      info_data = Build::Data.random_info

      info_from_api = Build::ApiResponse.info(info_data)
      expected_info = Build::ClientResponse.info(info_data)

      expect(Excon)
          .to(receive(:get)
              .with(Concourse::Urls.info_url(concourse_url))
              .and_return(
                  double('info response',
                      status: 200,
                      body: JSON.dump(info_from_api))))

      actual_info = client.get_info

      expect(actual_info).to(eq(expected_info))
    end
  end

  context 'for_skymarshal' do
    it 'returns a client for skymarshal authentication including the ' +
        'server version' do
      concourse_url = Build::Data.random_concourse_url

      client = Concourse::Client.new({
          url: concourse_url,
      })

      version = '4.1.0'

      info_data = Build::Data.random_info(version: version)
      info_response_body = Build::ApiResponse.info(info_data)

      allow(Excon)
          .to(receive(:get)
              .with(Concourse::Urls.info_url(concourse_url))
              .and_return(
                  double('info response',
                      status: 200,
                      body: JSON.dump(info_response_body))))

      skymarshal_client = client.for_skymarshal

      expect(skymarshal_client)
          .to(eq(Concourse::SubClients::SkymarshalClient.new({
              url: concourse_url,
              version: version
          })))
    end
  end
end
