module V1
  class Root < Grape::API
    version 'v1', using: :path
    format :json

    helpers V1::Helpers

    mount V1::Companies
    mount V1::Markets
    mount V1::Industries

    ## routing
  end
end