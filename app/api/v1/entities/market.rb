module V1
  module Entities
    class Market < Grape::Entity
      expose :id, documentation: { type: :integer, desc: 'Market ID', required: true }
      expose :name, documentation: { type: :string, desc: 'Market name.', required: true }
    end
  end
end