module V1
  class Markets < Grape::API

    resource :markets do
      desc 'Return All Market', is_array: true, entity: V1::Entities::Market
      get do
        markets = Market.all
        present markets, with: V1::Entities::Market
      end

      desc 'Return id matching Market', entity: V1::Entities::Market
      params do
        requires :id, type: Integer, desc: 'Market ID'
      end
      route_param :id do
        get do
          market = Market.find_by(id: request.params[:id])
          present market, with: V1::Entities::Market
        end
      end
    end
  end
end