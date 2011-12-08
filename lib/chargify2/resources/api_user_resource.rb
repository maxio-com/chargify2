module Chargify2
  class ApiUserResource < Resource
    path 'sites/:site_id/api_users'
    representation ApiUser
  end
end

