module SpecHelperMethods
  def valid_client_credentials
    {
      :api_id => '00000000-0000-0000-0000-000000000000',
      :api_password => 'notarealpassword',
      :api_secret => 'notarealsecret'
    }
  end
end
