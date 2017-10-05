module API
  class Root < Grape::API
    prefix :api

    mount V1::Root

    ## apiの設計ミスりました
  end
end