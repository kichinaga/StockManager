module V1
  class Industries < Grape::API

    resource :industry do
      desc 'Return All Industry', is_array: true, entity: V1::Entities::Industry
      get do
        industries = Industry.all
        present industries, with: V1::Entities::Industry
      end

      desc 'Return id matching Industry', entity: V1::Entities::Industry
      params do
        requires :id, type: Integer, desc: 'Industry ID'
      end
      route_param :id do
        get do
          industry = Industry.find_by(id: request.params[:id])
          present industry, with: V1::Entities::Industry
        end
      end
    end
  end
end