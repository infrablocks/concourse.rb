require 'spec_helper'

describe Concourse::Urls do
  it 'returns info URL' do
    concourse_url = "https://concourse.example.com"
    
    expect(Concourse::Urls.info_url(concourse_url))
        .to(eq("https://concourse.example.com/api/v1/info"))
  end
end
