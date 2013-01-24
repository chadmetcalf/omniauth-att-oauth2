require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class AttOauth2 < OmniAuth::Strategies::OAuth2
      
      args [:client_id, :client_secret, :short_code]

      option :name, 'att_oauth2'
      option :authorize_options, [:scope]
      option :short_code, nil

      option :client_options, {
        :site          => 'https://api.att.com',
        :authorize_url => '/oauth/authorize',
        :token_url     => '/oauth/token',
      }

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['id'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/me').parsed
      end
      
      
      
      
      #######################
      
      def authenticate_user_url
        "https://api.att.com/rest/sms/2/messaging/outbox"
      end
      
      def authorize_user_json        
         # --insecure
         # --request POST
         # --header "Accept: application/json"
         # --header "Authorization: Bearer 1c2939fd20f25a6e4d1dfe3801a9edc9"
         # --data "Address=tel%3A9139088480&Message='https://auth-api.att.com/user/login?client_id=#{}%26scope=SMS,TL"
      end
      

    end
  end
end