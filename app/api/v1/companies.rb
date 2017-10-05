module V1
  class Companies < Grape::API

    resource :companies do
      desc 'Return All Company', is_array: true, entity: V1::Entities::Company
      get do
        companies = Company.all
        present companies, with: V1::Entities::Company
      end

      desc 'Return id matching Company', entity: V1::Entities::Company
      params do
        requires :stock_code, type: Integer, desc: 'Company Stock Code'
      end
      route_param :stock_code do
        get do
          company = Company.find_by(stock_code: request.params[:stock_code])
          present company, with: V1::Entities::Company
        end
      end
    end

  end
end