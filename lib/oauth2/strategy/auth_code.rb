require 'multi_json'

module OAuth2
  module Strategy
    # The Authorization Code Strategy
    #
    # @see http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-4.1
    class AuthCode < Base
      # The required query parameters for the authorize URL
      #
      # @param [Hash] params additional query parameters
      def authorize_params(params={})
        super(params).merge('response_type' => 'code')
      end

      # The authorization URL endpoint of the provider
      #
      # @param [Hash] params additional query parameters for the URL
      def authorize_url(params={})
        @client.authorize_url(authorize_params.merge(params))
      end

      # Retrieve an access token given the specified validation code.
      #
      # @param [String] code The Authorization Code value
      # @param [Hash] params additional params
      # @note that you must also provide a :redirect_uri with most OAuth 2.0 providers
      def get_token(code, params={})
        params = { 'grant_type' => 'authorization_code', 'code' => code }.merge(client_params).merge(params)
        OAuth2::AccessToken.from_token_params(@client, params)
      end
    end
  end
end
