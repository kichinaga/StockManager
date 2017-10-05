module V1
  module Entities
    class Industry < Grape::Entity
      expose :id, documentation: { type: :integer, desc: 'Industry ID', required: true }
      expose :name, documentation: { type: :string, desc: 'Industry name.', required: true }
    end
  end
end