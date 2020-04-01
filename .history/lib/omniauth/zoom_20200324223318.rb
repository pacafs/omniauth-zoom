# frozen_string_literal: true

require 'omniauth/zoom/version'

module Omniauth
  class Zoom < OmniAuth::Strategies::OAuth2
    include OmniAuth::Strategy
    option :client_options, {
      site: 'https://zoom.com',
      authorize_url: 'https://learn.co/oauth/authorize',
      token_url: 'https://learn.co/oauth/token'
    }
    def request_phase
      super
    end
    info do
      raw_info.merge('token' => access_token.token)
    end
    uid { raw_info['id'] }
    def raw_info
      @raw_info ||=
        access_token.get('/api/users/me').parsed
    end
  end
end
