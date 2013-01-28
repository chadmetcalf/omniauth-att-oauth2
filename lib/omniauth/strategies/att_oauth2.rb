require 'multi_json'
require 'omniauth'
require 'omniauth-oauth2'
require 'omniauth/strategies/oauth2'
require 'json'

module OmniAuth
  module Strategies
    class AttOauth2 < OmniAuth::Strategies::OAuth2
      
      args [:client_id, :client_secret]
      
      option :name, "att_oauth2"
      option :authorize_options, [:scope]
      option :short_code, nil
      
      option :client_options, {
        # :verify           => false,
        :site             => 'https://api.att.com',
        :authorize_url    => '/oauth/authorize',
        :token_url        => '/oauth/token',
        :token_method     => :post,
        :endpoint_msisidn => "",
        :raise_errors     => false,
      }

      option :token_params, {
        :parse => :json,
      }

      def request_phase
        options[:scope] ||= "SMS,MMS,TL,DC"
        options[:authorize_params][:response_type] ||= 'code'
        super
      end

    end
  end
end

OmniAuth.config.add_camelization 'att', 'Att'