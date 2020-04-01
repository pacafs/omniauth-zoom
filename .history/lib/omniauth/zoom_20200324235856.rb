# frozen_string_literal: true

require 'omniauth/zoom/version'

module Omniauth
  module Strategies
    class Zoom < OmniAuth::Strategies::OAuth2
      include OmniAuth::Strategy

      option :client_options, {
        site: 'https://api.zoom.us',
        authorize_url: 'https://zoom.us/oauth/authorize',
        token_url: 'https://zoom.us/oauth/token',
        redirect_uri: ''
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
          access_token.get('/v2/users/me').parsed
      end
    end
  end
end
