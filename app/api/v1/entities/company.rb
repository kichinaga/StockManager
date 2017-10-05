module V1
  module Entities
    class Company < Grape::Entity
      expose :id, documentation: { type: :integer, desc: 'Company ID', required: true }
      expose :stock_code, documentation: { type: :integer, desc: 'Company Stock Code', required: true }
      expose :name, documentation: { type: :string, desc: 'Company name.', required: true }
      expose :market, using: V1::Entities::Market, documentation: { type: :string, desc: 'Company Market', required: true }
      expose :industry, using: V1::Entities::Industry, documentation: { type: :string, desc: 'Company Market', required: true }
    end
  end
end