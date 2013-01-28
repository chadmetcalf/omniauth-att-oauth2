require 'multi_json'
require 'omniauth'
require 'omniauth-oauth2'
require 'omniauth/strategies/oauth2'
require 'json'
require 'syslog'

module OmniAuth
  module Strategies
    class AttOauth2 < OmniAuth::Strategies::OAuth2
      
      args [:client_id, :client_secret]
      
      option :name, "att_oauth2"
      option :authorize_options, [:scope]
      option :short_code, nil
      # option :state

      option :client_options, {
        :site             => 'https://api.att.com',
        :authorize_url    => '/oauth/authorize',
        :token_url        => '/oauth/token',
        :endpoint_msisidn => "",
        :raise_errors     => true
      }

      option :token_params, {
        :parse => :json
      }

      # These are called after authentication has succeeded. 
      uid{ raw_info['uid'] }

      info do
        prune!({
          :name               => raw_info['info']['name'],
          :phone_number       => raw_info['info']['phone_number'],
          :email              => raw_info['info']['email'],
          :first_name         => raw_info['info']['first_name'],
          :last_name          => raw_info['info']['last_name']
        })
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def request_phase
        Syslog.open($0, Syslog::LOG_PID | Syslog::LOG_CONS) { |s| s.warning "IN THE CUSTOM request" }
        options[:scope] ||= "SMS,MMS,TL,DC"
        options[:authorize_params][:response_type] ||= 'code'
        options[:authorize_params][:state] = options[:state]
        super
      end
      
      #######################
      # def request_phase
      #   raise 
      #   options[:scope] ||= "SMS,MMS,TL,DC"
      #   redirect client.auth_code.authorize_url(
      #     {:redirect_uri => callback_url, :response_type => "code"}.merge(options))
      # end

    end
  end
end

OmniAuth.config.add_camelization 'att', 'Att'